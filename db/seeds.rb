USERS_TO_CREATE = [*1..20]
CREATE_TEST_ADMIN = 1
CREATE_TEST_DEV = 1
BUSINESS_STATUSES = %w(Running Closed Updating).freeze
AASM_STATE = %w(under_review
rejected
unreleased
released
incompatible).freeze
LIST_OF_TAGS = %w(Adventure
Action
Strategy
Multi-player
Co-op
Single-player
Sport
Racing).freeze
GAME_ID_FOR_TAG = 1
TAGGINGS_TO_CREATE = [*1..250]
LOADS_TO_CREATE = 1000
REVIEW_COUNT = 10
REVIEW_FOR_GAMES = 1000
CREATE_50_GAMES = [*1..50]
CREATE_100_GAMES = [*1..100]
CREATE_5_LOCATIONS = [*1..5]
CREATE_20_MACHINES = 20
TAGS_PER_GAME = 1 + rand(8)

puts 'creating users'
USERS_TO_CREATE.each do |x|
  User.create(company: Faker::Company.name + x.to_s,
              email: x.to_s + Faker::Internet.email,
              password: Faker::Internet.password,
              employees: rand(8),
              website: Faker::Internet.url + x.to_s)
end

puts 'creating test admin'
CREATE_TEST_ADMIN.times do
  User.create(company: 'Admin Man',
              email: 'admin@admin.com',
              password: '123456',
              employees: rand(8),
              website: Faker::Internet.url,
              admin: true)
end

puts 'creating test dev'
CREATE_TEST_DEV.times do
  User.create(company: 'Dev Man',
              email: 'dev@dev.com',
              password: '123456',
              employees: rand(8),
              website: Faker::Internet.url,
              admin: false)
end

puts 'creating locations'
CREATE_5_LOCATIONS.each do |number|
  Location.create(name:           Faker::Company.name + number.to_s,
                  address:        Faker::Address.street_address + number.to_s,
                  city:           Faker::Address.city + number.to_s,
                  postal_code:    Faker::Address.zip_code + number.to_s,
                  run_status:     BUSINESS_STATUSES.sample)
end

puts 'creating machines'
CREATE_20_MACHINES.times do
  Machine.create location_id:     1 + rand(5)
end

puts 'creating tags'
LIST_OF_TAGS.each do |t|
  Tag.create name: t
end

puts 'creating games, batch 1'
CREATE_100_GAMES.each do |number|
  Game.create(title: Faker::Hipster.word + number.to_s,
              description: Faker::Hipster.paragraph + number.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

puts 'creating games, batch 2'
CREATE_50_GAMES.each do |number|
  Game.create(title: Faker::Lorem.words(2).join(' ') + number.to_s,
              description: Faker::Hipster.paragraph + number.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

puts 'creating games, batch 3'
CREATE_50_GAMES.each do |number|
  Game.create(title: Faker::App.name + number.to_s,
              description: Faker::Hipster.paragraph + number.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

puts 'creating games, batch 4'
CREATE_50_GAMES.each do |number|
  Game.create(title: Faker::Book.title + number.to_s,
              description: Faker::Hipster.paragraph + number.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

puts 'creating taggings'
TAGGINGS_TO_CREATE.each do |game_id|
  TAGS_PER_GAME.times do
    Tagging.create(game_id: game_id,
                   tag_id: 1 + rand(8))
  end
end

puts 'creating loads'
LOADS_TO_CREATE.times do
  Load.create machine_id: 1 + rand(20),
              game_id:    1 + rand(200)
end

puts 'creating reviews'
REVIEW_FOR_GAMES.times do |game|
  REVIEW_COUNT.times do
    load_id = 1 + game
    Review.create	load_id:			load_id,
                  fun:					1 + rand(5),
                  difficulty:		1 + rand(5),
                  playability:	1 + rand(5),
                  game_id:    	Load.find(load_id).game.id
  end
end
