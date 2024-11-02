class PostDetail < ApplicationRecord
  belongs_to :post

  mount_uploader :image, PostDetailImageUploader
end
