# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
	Game.create({title: Faker::StarWars.specie, cpu: (rand()*100+1), gpu: (rand()*50+1), ram: (4+rand()*17), size: (1+ rand()*4), current_status: "Pending" })
end

p "done."
