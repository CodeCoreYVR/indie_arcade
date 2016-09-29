USERS_TO_CREATE = 20
NUMBER = 0

USERS_TO_CREATE.times do
  NUMBER += 1
  User.create(company: Faker::Company.name + NUMBER.to_s,
              email: NUMBER.to_s + Faker::Internet.email,
              password: Faker::Internet.password,
              employees: rand(8),
              website: Faker::Internet.url + NUMBER.to_s)
end

CREATE_TEST_ADMIN = 1
CREATE_TEST_ADMIN.times do
  User.create(company: 'Admin Man',
              email: 'admin@admin.com',
              password: '123456',
              employees: rand(8),
              website: Faker::Internet.url,
              admin: true)
end

CREATE_TEST_DEV = 1
CREATE_TEST_DEV.times do
  User.create(company: 'Dev Man',
              email: 'dev@dev.com',
              password: '123456',
              employees: rand(8),
              website: Faker::Internet.url,
              admin: false)
end

BUSINESS_STATUSES = %w(Running Closed Updating).freeze
5.times do
  NUMBER += 1
  Location.create(name:           Faker::Company.name + NUMBER.to_s,
                  address:        Faker::Address.street_address + NUMBER.to_s,
                  city:           Faker::Address.city + NUMBER.to_s,
                  postal_code:    Faker::Address.zip_code + NUMBER.to_s,
                  run_status:     BUSINESS_STATUSES.sample)
end

20.times do
  Machine.create location_id:     1 + rand(5)
end

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
LIST_OF_TAGS.each do |t|
  Tag.create name: t
end

100.times do
  NUMBER += 1
  Game.create(title: Faker::Hipster.word + NUMBER.to_s,
              description: Faker::Hipster.paragraph + NUMBER.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

50.times do
  NUMBER += 1
  Game.create(title: Faker::Lorem.words(2).join(' ') + NUMBER.to_s,
              description: Faker::Hipster.paragraph + NUMBER.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

50.times do
  NUMBER += 1
  Game.create(title: Faker::App.name + NUMBER.to_s,
              description: Faker::Hipster.paragraph + NUMBER.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

50.times do
  NUMBER += 1
  Game.create(title: Faker::Book.title + NUMBER.to_s,
              description: Faker::Hipster.paragraph + NUMBER.to_s,
              user_id: 1 + rand(22),
              cpu: rand(100) + 1,
              gpu: rand(50) + 1,
              ram: 4 + rand(17),
              size: 1 + rand(4),
              aasm_state: AASM_STATE.sample)
end

GAME_ID_FOR_TAG = 1
TAGGINGS_TO_CREATE = 250
TAGGINGS_TO_CREATE.times do
  TAGS_PER_GAME = 1 + rand(8)
  TAGS_PER_GAME.times do
    Tagging.create(game_id: GAME_ID_FOR_TAG,
                   tag_id: 1 + rand(8))
  end
  GAME_ID_FOR_TAG += 1
end

LOADS_TO_CREATE = 1000
LOADS_TO_CREATE.times do
  Load.create machine_id: 1 + rand(20),
              game_id:    1 + rand(200)
end

REVIEW_COUNT = 10
REVIEW_FOR_GAMES = 1000
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
