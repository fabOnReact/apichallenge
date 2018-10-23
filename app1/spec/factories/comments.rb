FactoryBot.define do
  factory :comment do
    user
    message { "MyString" }
    description { "MyString" }
  end
end
