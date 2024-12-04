class Post < ApplicationRecord
  has_many :post_details, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :post_details, allow_destroy: true

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true
  validates :departure_date, presence: true
  validate :day_after_today

  mount_uploader :image, PostImageUploader

  belongs_to :user

  def day_after_today
    unless departure_date == nil
      errors.add(:departure_date, "は過去の日付を入力してください") if departure_date >= Date.today
    end
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
