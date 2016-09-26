FactoryGirl.define do
  factory :user do
    company { Faker::Company.name }
    employees { rand(100) }
    website { Faker::Internet.url }
    genres { Faker::Book.genre }
    twitter { Faker::Internet.url('twitter.com') }
    sequence(:email) {|n| Faker::Internet.email.gsub("@", "-#{n}@") }
    password "helloworld"
  end
end
