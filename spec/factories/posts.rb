FactoryBot.define do
  factory :post do
    title { "title" }
    departure_date { '002024-12-01' }
    image { 'app/assets/images/DayOutLog.png' }
    status { 1 }

    association :user
  end
end
