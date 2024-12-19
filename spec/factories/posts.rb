FactoryBot.define do
  factory :post do
    title { "title" }
    departure_date { Date.today }
    image { 'app/assets/images/woman.png' }
    status { 1 }

    association :user
  end
end
