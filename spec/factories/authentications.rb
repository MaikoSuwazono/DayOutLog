FactoryBot.define do
  factory :authentication do
    provider { "google" }
    uid { "100788668331137654095" }

    association :user
  end
end
