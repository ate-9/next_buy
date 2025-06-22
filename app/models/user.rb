class User < ApplicationRecord
  has_many :authored_lists, class_name: "List", foreign_key: "author_id", dependent: :nullify
  has_many :buyer_lists,    class_name: "List", foreign_key: "buyer_id",  dependent: :nullify
end
