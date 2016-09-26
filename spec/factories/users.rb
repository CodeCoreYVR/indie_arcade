FactoryGirl.define do
  factory :user do
    sequence(:company) { |n| "McDonalds #{n}" }
    sequence(:email) { |n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password  { Faker::Internet.password}
    admin false
    # activated true
  end

  factory :admin, class: User do
    sequence(:company) { |n| "McDonalds #{n}" }
    sequence(:email) { |n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password  { Faker::Internet.password}
    admin true
    # activated false
  end
end
