FactoryGirl.define do
  factory :email, class: OpenStruct do
    to 'bookmark@example.com'
    from({ email: "sender@example.com" })
    subject 'Email subject'
    body 'http://example.com'
  end
end
