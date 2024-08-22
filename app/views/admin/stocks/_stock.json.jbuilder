json.extract! stock, :id, :size, :amount, :product_id, :created_at, :updated_at
json.url admin_stock_url(stock, format: :json)
