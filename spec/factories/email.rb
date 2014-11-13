FactoryGirl.define do
  factory :email, class: OpenStruct do
    to 'bookmark@example.com'
    from({ email: "sender@example.com", name: "Sender" })
    subject 'Email subject'
    body 'http://example.com'
  end
end
