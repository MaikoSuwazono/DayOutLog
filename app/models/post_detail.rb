class PostDetail < ApplicationRecord
  belongs_to :post

  validates :body, presence: true
  validates :arrival_at, presence: true

  mount_uploader :image, PostDetailImageUploader
end
