# 代码生成时间: 2025-09-07 18:40:03
# 引入CUBA框架所需的模块

# 定义一个名为Order的数据模型
class Order < CUBA::Entity
  # 定义属性，包括订单编号、客户名称、日期和订单详情
  # 每个属性都有对应的getter和setter方法
  string :number, required: true, unique: true
  string :customerName, required: true
  datetime :date, required: true
  string :details, required: true

  # 定义关联，每个订单可以包含多个订单项
  # 这里使用one_to_many关联，因为一个订单可以包含多个订单项，但一个订单项只能属于一个订单
  one_to_many :items, class_name: 'OrderItem', inverse: 'order'

  # 定义验证方法，确保订单数据的合法性
  validates :number, presence: true, uniqueness: true
  validates :customerName, presence: true
  validates :date, presence: true
  validates :details, presence: true

  # 错误处理方法，用于记录和处理验证失败或其他错误
  def validate
    # 检查订单编号是否为空
    if number.blank?
      errors.add(:number, 'must be present')
    end
    # 检查客户名称是否为空
    if customerName.blank?
      errors.add(:customerName, 'must be present')
    end
    # 检查日期是否为空
    if date.blank?
      errors.add(:date, 'must be present')
    end
    # 检查订单详情是否为空
    if details.blank?
      errors.add(:details, 'must be present')
    end
  end
end

# 定义一个名为OrderItem的数据模型
class OrderItem < CUBA::Entity
  # 定义属性，包括订单项编号、产品名称、数量和单价
  string :number, required: true, unique: true
  string :productName, required: true
  integer :quantity, required: true
  decimal :price, required: true

  # 定义关联，订单项属于一个订单
  # 这里使用many_to_one关联，因为一个订单项只能属于一个订单，但一个订单可以包含多个订单项
  many_to_one :order, class_name: 'Order', inverse: 'items'

  # 定义验证方法，确保订单项数据的合法性
  validates :number, presence: true, uniqueness: true
  validates :productName, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  # 错误处理方法，用于记录和处理验证失败或其他错误
  def validate
    # 检查订单项编号是否为空
    if number.blank?
      errors.add(:number, 'must be present')
    end
    # 检查产品名称是否为空
    if productName.blank?
      errors.add(:productName, 'must be present')
    end
    # 检查数量是否为空
    if quantity.blank?
      errors.add(:quantity, 'must be present')
    end
    # 检查单价是否为空
    if price.blank?
      errors.add(:price, 'must be present')
    end
  end
end