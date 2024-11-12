class PostDetail < ApplicationRecord
  belongs_to :post

  validates :body, presence: true
  validates :arrival_at, presence: true
  validate :place_name, :address

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  mount_uploader :image, PostDetailImageUploader
end
