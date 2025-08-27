# 代码生成时间: 2025-08-27 13:56:04
# test_data_generator.rb
# 测试数据生成器，用于创建测试所需的数据

require 'faker'

class TestDataGenerator
  # 生成指定数量的用户数据
  # @param count [Integer] 需要生成的用户数据数量
  def generate_users(count)
    
    # 检查输入是否为正整数
    raise ArgumentError, 'Count must be a positive integer' unless count.is_a?(Integer) && count > 0
    
    users = []
    count.times do |index|
      user = {id: index + 1, name: Faker::Name.name, email: Faker::Internet.email}
      users << user
    end
    
    users
  end

  # 生成指定数量的商品数据
  # @param count [Integer] 需要生成的商品数据数量
  def generate_products(count)
    
    # 检查输入是否为正整数
    raise ArgumentError, 'Count must be a positive integer' unless count.is_a?(Integer) && count > 0
    
    products = []
    count.times do |index|
      product = {id: index + 1, name: Faker::Commerce.product_name, price: Faker::Commerce.price}
      products << product
    end
    
    products
  end

  # 生成指定数量的订单数据
  # @param count [Integer] 需要生成的订单数据数量
  def generate_orders(count)
    
    # 检查输入是否为正整数
    raise ArgumentError, 'Count must be a positive integer' unless count.is_a?(Integer) && count > 0
    
    orders = []
    count.times do |index|
      order = {id: index + 1, user_id: Faker::Number.between(from: 1, 10), product_id: Faker::Number.between(from: 1, 10), quantity: Faker::Number.between(from: 1, 5)}
      orders << order
    end
    
    orders
  end

  # 生成指定数量的测试数据
  # @param user_count [Integer] 需要生成的用户数据数量
  # @param product_count [Integer] 需要生成的商品数据数量
  # @param order_count [Integer] 需要生成的订单数据数量
  def generate_test_data(user_count, product_count, order_count)
    users = generate_users(user_count)
    products = generate_products(product_count)
    orders = generate_orders(order_count)
    
    {users: users, products: products, orders: orders}
  end
end

# 示例用法
begin
  
  # 创建测试数据生成器实例
  generator = TestDataGenerator.new
  
  # 生成测试数据
  test_data = generator.generate_test_data(10, 20, 30)
  
  # 输出生成的测试数据
  puts 'Generated Users:'
  p test_data[:users]
  puts 'Generated Products:'
  p test_data[:products]
  puts 'Generated Orders:'
  p test_data[:orders]

rescue ArgumentError => e
  # 处理参数错误
  puts "Error: #{e.message}"
end