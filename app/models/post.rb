class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :departure_date, presence: true, uniqueness: true

  belongs_to :user
end
