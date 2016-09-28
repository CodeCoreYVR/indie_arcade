USERS_TO_CREATE = 20
NUMBER = 0
USERS_TO_CREATE.times do
	NUMBER+=1
	User.create({	company:					Faker::Company.name + "#{NUMBER}",
								email:						"#{NUMBER}" + Faker::Internet.email,
								password:	        Faker::Internet.password,
								employees:				rand(8),
								website:					Faker::Internet.url + "#{NUMBER}"
							})
end
# works

User.create({ 	company:					"Admin Man",
								email:						"admin@admin.com",
								password:	        "123456",
								employees:				rand(8),
								website:					Faker::Internet.url,
								admin:						true
							})

User.create ({	company:					"Dev Man",
								email:						"dev@dev.com",
								password:	        "123456",
								employees:				rand(8),
								website:					Faker::Internet.url,
								admin:						false
							})

business = ["Running", "Closed", "Updating"]
5.times do
	NUMBER+=1
  Location.create({	name:           Faker::Company.name + "#{NUMBER}",
                  	address:        Faker::Address.street_address + "#{NUMBER}",
                    city:           Faker::Address.city + "#{NUMBER}",
                    postal_code:    Faker::Address.zip_code + "#{NUMBER}",
                    run_status:     business.sample
									})
end

20.times do
    Machine.create location_id:     1+rand(5)
end

["under_review", "rejected", "unreleased", "released", "incompatible"].each do |s|
	Status.create name: s
end

["Adventure", "Action", "Strategy", "Multi-player", "Co-op", "Single-player", "Sport", "Racing"].each do |t|
    Tag.create name: t
end

100.times do
	NUMBER+=1
  Game.create({				title: Faker::Hipster.word + "#{NUMBER}",
                			description: Faker::Hipster.paragraph + "#{NUMBER}",
                      user_id: 1+rand(22),
                      cpu: rand(100)+1,
                      gpu: rand(50)+1,
                      ram: 4+rand(17),
                      size: 1+ rand(4),
                      status_id: 1 + rand(5) })
end

50.times do
	NUMBER+=1
  Game.create({				title: Faker::Lorem.words(2).join(" ") + "#{NUMBER}",
		                  description: Faker::Hipster.paragraph + "#{NUMBER}",
                      user_id: 1+rand(22),
                      cpu: rand(100)+1,
                      gpu: rand(50)+1,
                      ram: 4+rand(17),
                      size: 1+ rand(4),
                      status_id: 1 + rand(5) })
end

50.times do
	NUMBER+=1
  Game.create({				title: Faker::App.name + "#{NUMBER}",
		                  description: Faker::Hipster.paragraph + "#{NUMBER}",
                      user_id: 1+rand(22),
                      cpu: rand(100)+1,
                      gpu: rand(50)+1,
                      ram: 4+rand(17),
                      size: 1+ rand(4),
                      status_id: 1 + rand(5) })
end

50.times do
	NUMBER+=1
  Game.create({				title: Faker::Book.title + "#{NUMBER}",
			                description: Faker::Hipster.paragraph + "#{NUMBER}",
                      user_id: 1+rand(22),
                      cpu: rand(100)+1,
                      gpu: rand(50)+1,
                      ram: 4+rand(17),
                      size: 1+ rand(4),
                      status_id: 1 + rand(5) })
end

TAGGINGS_TO_CREATE = 400
TAGGINGS_TO_CREATE.times do
 Tagging.create(game_id: rand(200)+1,
                tag_id: 1+rand(8))
end

LOADS_TO_CREATE = 1000
LOADS_TO_CREATE.times do
  Load.create machine_id: 1+rand(20),
              game_id:    1+rand(200)
end

REVIEW_COUNT = 10
REVIEW_FOR_GAMES = 1000
REVIEW_FOR_GAMES.times do |game|
	REVIEW_COUNT.times do
		load_id = 1 + game
		Review.create	load_id:			load_id,
									fun:					1+rand(5),
									difficulty:		1+rand(5),
									playability:	1+rand(5),
									game_id:    	Load.find(load_id).game.id
	end
end
