class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :departure_date, presence: true, uniqueness: true
  validate :day_after_today

  belongs_to :user

  def day_after_today
    unless departure_date == nil
      errors.add(:departure_date, "は過去の日付を入力して下さい") if departure_date >= Date.today
    end
  end
end
