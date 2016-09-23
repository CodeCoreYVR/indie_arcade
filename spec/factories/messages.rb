FactoryGirl.define do
  factory :message do
    email { Faker::Internet.email }
    content { Faker::StarWars.quote }
  end
end
