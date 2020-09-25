# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def text_brake(text)
  separator = "#---------------------------------------#"
  puts ''
  puts text
  puts ''
  puts separator
end

text_brake('Start seeding')

test_user1 = User.create(username:'username', password:'password', first_name:'first_name', last_name:'last_name')
test_user2 = User.create(username:'username2', password:'password', first_name:'first_name_again', last_name:'last_name_again')

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name 
  username = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w(. _ -))
  password = 'testapp'

  User.create(username:username, password:password, first_name:first_name, last_name:last_name)
end

text_brake('Users generated')

25.times do
  title = Faker::Lorem.sentence(word_count: 2, supplemental: true, random_words_to_add: 2)

  Conversation.create(title:title)
end

text_brake('Conversations generated')

test_users = [test_user1, test_user2]

10.times do
  text = Faker::TvShows::MichaelScott.quote
  user = test_users.sample
  
  Message.create(text: text, user: user, conversation: Conversation.first)
end

50.times do
  text = Faker::TvShows::MichaelScott.quote
  user = User.all.sample
  conversation = Conversation.all.sample

  Message.create(text: text, user: user, conversation: conversation)
end

text_brake("Messages generated, all seeded")