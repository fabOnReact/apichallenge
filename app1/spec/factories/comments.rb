FactoryBot.define do
  factory :comment do
    user
    message { Faker::Twitter.status[:text]  }
    description { Faker::Team.sport }
  end
end
