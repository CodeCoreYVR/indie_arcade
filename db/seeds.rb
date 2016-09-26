USERS_TO_CREATE = 20
RANDOM_NUMBER = rand(1..1000)
USERS_TO_CREATE.times do
	number = 1++
	User.create({	company:					Faker::Company.name + "#{number * RANDOM_NUMBER}",
								email:						"#{number * RANDOM_NUMBER}" + Faker::Internet.email,
								password:	        Faker::Internet.password,
								employees:				rand(8),
								website:					Faker::Internet.url + "#{number * RANDOM_NUMBER}"
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
	number = 1++
    Location.create({	name:           Faker::Company.name + "#{number * RANDOM_NUMBER}",
	                  	address:        Faker::Address.street_address + "#{number * RANDOM_NUMBER}",
	                    city:           Faker::Address.city + "#{number * RANDOM_NUMBER}",
	                    postal_code:    Faker::Address.zip_code + "#{number * RANDOM_NUMBER}",
	                    run_status:     business.sample
										})
end

20.times do
    Machine.create location_id:     1+rand(5)
end

["Adventure", "Action", "Strategy", "Multi-player", "Co-op", "Single-player", "Sport", "Racing"].each do |t|
    Tag.create name: t
end

100.times do
	number = 1++
    Game.create({				title: Faker::Hipster.word + "#{number * RANDOM_NUMBER}",
                  			description: Faker::Hipster.paragraph + "#{number * RANDOM_NUMBER}",
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["Released to arcade", "Not released", "Game under review", "Game not uploaded, it is not compatible with the system", "Rejected"].sample })
end

50.times do
	number = 1++
    Game.create({				title: Faker::Lorem.words(2).join(" ") + "#{number * RANDOM_NUMBER}",
			                  description: Faker::Hipster.paragraph + "#{number * RANDOM_NUMBER}",
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["Released to arcade", "Not released", "Game under review", "Game not uploaded, it is not compatible with the system", "Rejected"].sample })
end

50.times do
    Game.create({				title: Faker::App.name + "#{number * RANDOM_NUMBER}",
			                  description: Faker::Hipster.paragraph + "#{number * RANDOM_NUMBER}",
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["Released to arcade", "Not released", "Game under review", "Game not uploaded, it is not compatible with the system", "Rejected"].sample })
end

50.times do
    Game.create({				title: Faker::Book.title + "#{number * RANDOM_NUMBER}",
				                description: Faker::Hipster.paragraph + "#{number * RANDOM_NUMBER}",
                        user_id: 1+rand(22),
                        cpu: rand(100)+1,
                        gpu: rand(50)+1,
                        ram: 4+rand(17),
                        size: 1+ rand(4),
                        aasm_state: ["Released to arcade", "Not released", "Game under review", "Game not uploaded, it is not compatible with the system", "Rejected"].sample })
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

REVIEW_TO_CREATE = 5000
REVIEW_TO_CREATE.times do
	l = 1+ rand(1000)
	r = Review.create	load_id:			l,
										fun:					1+rand(5),
										difficulty:		1+rand(5),
										playability:	1+rand(5),
										game_id:    	Load.find(l).game.id
end
