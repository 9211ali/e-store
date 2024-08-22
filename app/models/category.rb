class Category < ApplicationRecord

  #active storage
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end

  # associations
  has_many :products, dependent: :destroy
end
