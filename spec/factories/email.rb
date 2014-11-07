FactoryGirl.define do
  factory :email, class: OpenStruct do
    to [{email: 'bookmark@example.com'} ]
    from ({ email: "sender@example.com" })
    subject 'Email subject'
    body 'www.example.com'
  end
end