class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :authored_lists, class_name: "List", foreign_key: "author_id", dependent: :nullify
  has_many :buyer_lists,    class_name: "List", foreign_key: "buyer_id",  dependent: :nullify

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :name, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
