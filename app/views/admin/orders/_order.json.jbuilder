json.extract! order, :id, :customer_email, :status, :address, :total_amount, :created_at, :updated_at
json.url admin_order_url(order, format: :json)
