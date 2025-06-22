class List < ApplicationRecord
  # 属してるリストについて
  belongs_to :author, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true # 必須ではない

  # 持っているアイテムについて
  has_many :items, dependent: :destroy
end
