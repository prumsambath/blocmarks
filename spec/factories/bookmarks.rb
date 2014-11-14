FactoryGirl.define do
  factory :bookmark do
    url "http://example.com" # Faker::Internet.url
    user
  end

  factory :invalid_bookmark, class: Bookmark do
    url ""
    user
  end
end
