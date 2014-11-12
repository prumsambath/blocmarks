FactoryGirl.define do
  factory :unsigned_up_user do
    name "John Smith"
    sequence(:email) { |n| "john#{n}@example.com" }
  end
end
