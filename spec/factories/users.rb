FactoryGirl.define do
  factory :user do
    company { "Company1"}
    sequence(:email) { |n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password  { Faker::Internet.password}
    admin false
    # activated true
  end

  factory :admin, class: User do
    company { "Company2Admin"}
    sequence(:email) { |n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password  { Faker::Internet.password}
    admin true
    # activated false
  end
end
