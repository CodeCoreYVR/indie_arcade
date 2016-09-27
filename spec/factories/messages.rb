FactoryGirl.define do
  factory :message do
    email { Faker::Internet.email }
    content { Faker::Lorem.characters(50) }
    
    factory :invalid_short_message do
      content "abc"
    end

    factory :invalid_no_message do
      content ""
    end
  end
end
