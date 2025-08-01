# 代码生成时间: 2025-08-01 09:45:05
# shopping_cart.rb
# This Ruby script implements a simple shopping cart using the Cuba framework.

require 'cuba'
require 'cuba/plugin/flash'
require 'cuba/plugin/rescue'
require 'cuba/plugin/reloader'
require 'cuba/plugin/reloader' if Cuba.env == 'development'

# Data storage for products and cart items.
# In a real application, this data would be stored in a database.
$products = {
  "001" => { name: "Product A", price: 10.0 },
  "002" => { name: "Product B", price: 20.0 },
  "003" => { name: "Product C", price: 30.0 }
}

$cart = {}

# Middleware to handle errors
Cuba.use Cuba::Rescue do
  error do |e, env|
    [
      400,
      {
        'Content-Type' => 'text/html'
      },
      ['<p>Internal Server Error</p>']
    ]
  end
end

# Middleware to handle flash messages
Cuba.use Rack::Flash

# Middleware to reload the application in development environment
Cuba.plugin Cuba::Reloader

# A helper method to add a product to the cart
# Adds a product by its ID to the cart, increasing the quantity if it already exists
helpers do
  def add_to_cart(product_id)
    if $products[product_id]
      if $cart[product_id]
        $cart[product_id][:quantity] += 1
      else
        $cart[product_id] = { quantity: 1, product: $products[product_id] }
      end
    else
      flash[:error] = "Product with ID #{product_id} does not exist."
    end
  end
end

# Routes
Cuba.define do
  # Home page
  on get do
    res.write "Welcome to the shopping cart application."
  end

  # Route to show the cart contents
  on get, 'cart' do
    cart_contents = $cart.map { |id, item| "#{item[:quantity]} x #{item[:product][:name]} - "#{item[:product][:price]}"" }.join('<br>')
    res.write "Your cart contains:<br>#{cart_contents}"
  end

  # Route to add a product to the cart
  on post, 'add_to_cart' do
    product_id = request.params['product_id']
    add_to_cart(product_id)
    res.redirect 'cart'
  end

  # Route to clear the cart
  on post, 'clear_cart' do
    $cart.clear
    res.redirect 'cart'
  end

  # Route to show all products (for demonstration purposes)
  on get, 'products' do
    products_list = $products.map { |id, product| "ID: #{id}, Name: #{product[:name]}, Price: "#{product[:price]}"" }.join('<br>')
    res.write "Available products:<br>#{products_list}"
  end
end
