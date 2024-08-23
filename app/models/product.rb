class Product < ApplicationRecord
  enum status: [ :active, :inactive ]

  # active storage
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end

  # associatons
  belongs_to :category
  has_many :stocks, dependent: :destroy
  
  # Automatic deletion of join models is direct, no destroy callbacks are triggered.
  has_many :order_products
  has_many :orders, through: :order_products
end
