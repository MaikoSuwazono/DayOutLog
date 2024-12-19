FactoryBot.define do
  factory :post_detail do
    body { 'aaa' }
    arrival_at { Time.now }
    image { 'app/assets/images/woman.png' }
    address { '〒812-0012 福岡県福岡市博多区博多駅中央街１−１' }
    latitude { 33.58993973664673 }
    longitude { 130.42074934032092 }
    place_name { '博多駅' }

    association :post
  end
end
