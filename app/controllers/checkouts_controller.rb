class CheckoutsController < ApplicationController

  def create
    puts "hit create"
    stripe_secret_key = Rails.application.credentials.dig(:stripe_secret_key)
    Stripe.api_key = stripe_secret_key
    cart = params[:cart]
    line_items = cart.map do |item|
      product = Product.find(item["id"])
      product_stock = product.stocks.find { |stock| stock.size == item["size"] }
      if product_stock.amount < item['quantity'].to_i
        render json: { message: "Not enough stock for #{product.name} in size: #{item['size']}. Only #{product_stock.amount} left." }, status: 400
        return
      end
      {
        quantity: item['quantity'].to_i,
        price_data: {
          currency: 'usd',
          unit_amount: item['price'].to_i,
          product_data: {
            name: product.name,
            metadata: { product_id: product.id, product_stock_id: product_stock.id, size: item['size']}
          }
        }
      }
    end
    session = Stripe::Checkout::Session.create(
      mode: 'payment',
      line_items: line_items,
      success_url: 'http://localhost:3000/success',
      cancel_url: 'http://localhost:3000/cancel',
      shipping_address_collection: {
        allowed_countries: ['US', 'CA'],
      }
    )
    render json: { url: session.url }
  end
end
