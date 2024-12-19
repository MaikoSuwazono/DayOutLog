FactoryBot.define do
  factory :comment do
    body { "body" }

    association :user
    association :post
  end
end
