Message.delete_all
Inbox.delete_all
User.delete_all

rand(2..3).times do
  faker_email = Faker::Internet.email
  user = User.create(email: faker_email,
                     password: Devise.friendly_token[0, 20])

  rand(2..5).times do
    faker_name = Faker::Quote.famous_last_words
    inbox = Inbox.create(name: faker_name,
                 user: user)

    rand(2..5).times do
      faker_body = Faker::Lorem.question
      Message.create(body: faker_body,
                     inbox: inbox,
                     user: user)
                     # TODO: make it a random user
                     # add random votes
    end
  end
end

p "#{User.count} users added"
p "#{Inbox.count} inboxes added"
p "#{Message.count} messages added"
