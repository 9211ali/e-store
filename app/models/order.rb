class Order < ApplicationRecord
  # enums
  enum status: [ :pending, :completed, :canceled ]
  # associations
  has_many :order_products
  has_many :products, through: :order_products
end
