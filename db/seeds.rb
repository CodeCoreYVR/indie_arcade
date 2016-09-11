

USERS_TO_CREATE = 10

USERS_TO_CREATE.times do
	User.create company:					Faker::Company.name,
							email:						Faker::Internet.email,
							password_digest:	Faker::Internet.password,
							employees:				rand(8),
							website:					Faker::Internet.url

end

5.times do
	Location.create	name:					Faker::Company.name,
									address:			Faker::Address.street_address,
									city:					Faker::Address.city,
									postal_code:	Faker::Address.zip_code
end

20.times do
	Machine.create location_id:		1+rand(5)
end

100.times do
	Game.create({title: Faker::StarWars.specie,
											user_id: 1+rand(10),
											cpu: (rand()*100+1),
											gpu: (rand()*50+1),
											ram: (4+rand()*17),
											size: (1+ rand()*4),
											current_status: "Pending" })
end


["Adventure", "Action", "Strategy", "Multi-player", "Co-op", "Single-player", "Sport", "Racing"].each do |t|
	Tag.create name: t
end

TAGGINGS_TO_CREATE = 2000
TAGGINGS_TO_CREATE.times do
  t = Tagging.create(game_id: rand(60)+1,
                  tag_id: 1+rand(8))
end

LOADS_TO_CREATE = 100
LOADS_TO_CREATE.times do
	Load.create machine_id: 1+rand(20),
							game_id:		1+rand(100)
end

REVIEW_TO_CREATE = 500
REVIEW_TO_CREATE.times do
	Review.create 	load_id:			1+rand(100),
									fun:					1+rand(5),
									difficulty:		1+rand(5),
									playability:	1+rand(5)

end

["Released to arcade", "Not released", "Game under review", "Game not uploaded, it is not compatible with the system", "Rejected"].each do |s|
	Status.create name: s
end
