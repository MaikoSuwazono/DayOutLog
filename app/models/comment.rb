class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :user
  belongs_to :post
end
