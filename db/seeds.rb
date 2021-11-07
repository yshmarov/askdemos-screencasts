return unless Rails.env.development? # || Rails.env.test?

Message.delete_all
Inbox.delete_all
User.delete_all


# optional 1
def check_uniq_message_body(message_body)
  if Message.where(body: message_body).any?
    Faker::Hipster.unique.paragraph + " Part: (#{Devise.friendly_token[0, 4]})"
  else
    message_body
  end
end

# optional 2
User.create!(email: 'admin@example.com', password: 'password') # lazy create new user in browser

6.times do
  faker_email = Faker::Internet.unique.email
  user = User.create!(email: faker_email,
                      # password: Devise.friendly_token[0, 20]) # why?!!!
                      password: 'password')
  print '.'

  rand(1..5).times do
    # faker_name = Faker::Quote.famous_last_words  # very-very long - bad idea!!!
    faker_name = Faker::Name.unique.name_with_middle # like better! (e.g. "Gov. Aron Schumm Quitzon")
    inbox = Inbox.create!(name: faker_name, user: user)
    print '.'

    rand(1..5).times do
      # message_body = Faker::Hipster.unique.paragraph # have limit uniq records
      message_body = check_uniq_message_body(Faker::Hipster.unique.paragraph)  # optional 3
      Message.create!(body: message_body,
                      inbox: inbox,
                      # user_id: rand(1..User.count)
                      user: User.all.sample) # non author? User.where.not(email: user.email).sample
      print '.'
    end
  end
end

puts '. All Ok!'
puts "Created #{User.count} unique users."
puts "Created #{Inbox.count} unique inboxes."
puts "Created #{Message.count} unique messages."
puts '[Admin] admin@example.com:password' # optional 4
