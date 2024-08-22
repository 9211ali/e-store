class Order < ApplicationRecord
 #enums
  enum status: [ :inprgress, :completed, :canceled ]
end
