FactoryGirl.define do
  factory :game do
    association :user, factory: :user
    title {Faker::Hipster.sentence(2)}
    cpu 5000
    gpu 5000
    ram 5000
    size 5000
    description "Valid game description"
    aasm_state "released"
  end
end
