class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { in: 8..20 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
end
