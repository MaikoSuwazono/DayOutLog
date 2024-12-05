class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { in: 8..20 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  has_many :posts, dependent: :destroy
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def own?(object)
    self.id == object.user_id
  end
end
