return unless Rails.env.development?

Message.delete_all
Inbox.delete_all
User.delete_all

MESSAGE_STATUSES = Message.statuses.flatten.uniq

rand(2..3).times do
  faker_email = Faker::Internet.unique.email
  user = User.create(email: faker_email,
                     password: Devise.friendly_token[0, 20],
                     confirmed_at: Time.zone.now)
  # user.skip_confirmation!
  print('.')

  rand(2..5).times do
    faker_name = Faker::Lorem.unique.question(word_count: 5)
    inbox = Inbox.create(name: faker_name,
                 user: user)
    print('.')

    rand(2..5).times do
      faker_body = Faker::Lorem.question
      Message.create(body: faker_body,
                     inbox: inbox,
                     user: User.all.sample,
                     status: MESSAGE_STATUSES.sample)
      print('.')
    end
  end
end

# add random votes
Message.all.sample(rand(1...Message.count)).each { |message| message.upvote!(User.all.sample) }
print('.')

puts '.All Ok!'
p "#{User.count} users added."
p "#{Message.where.not(cached_votes_up: 0).count} voted added."
p "#{Inbox.count} inboxes added."
messages = Message.all.group_by(&:'status')
p "#{Message.count} messages added: (incomming: #{messages['incoming'].count}, \
todo: #{messages['todo'].count}, done: #{messages['done'].count}, \
spam: #{messages['spam'].count})"
