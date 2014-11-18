FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    password "helloworld"

    factory :user_with_avatar do
      avatar { File.new("#{Rails.root}/spec/factories/avatar.png") }
    end
  end
end

