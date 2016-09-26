FactoryGirl.define do
  factory :message do
    email { Faker::Internet.email }
    content { Faker::Lorem.characters(50) }
  end

end
