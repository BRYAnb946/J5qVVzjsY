# 代码生成时间: 2025-09-12 10:16:04
# data_analysis.rb

# 数据统计分析器
#
# 该类提供基础的数据分析功能，如计算平均值、最大值和最小值。
class DataAnalysis
  # 构造函数，接收数据数组
  def initialize(data)
    @data = data
    raise ArgumentError, '数据不能为空' if @data.nil? || @data.empty?
  end

  # 计算平均值
  #
  # @return [Float] 数据的平均值
  def average
    total = 0
    @data.each { |number| total += number }
    total / @data.size.to_f
  end

  # 计算最大值
  #
  # @return [Number] 数据中的最大值
  def max
    @data.max
  end

  # 计算最小值
  #
  # @return [Number] 数据中的最小值
  def min
    @data.min
  end

  # 打印分析结果
  #
  # @return [void] 打印平均值、最大值和最小值
  def print_results
    puts "平均值: #{average}"
    puts "最大值: #{max}"
    puts "最小值: #{min}"
  end
end

# 示例代码
if __FILE__ == $0
  # 定义数据数组
  data = [10, 20, 30, 40, 50]
  analyzer = DataAnalysis.new(data)

  # 打印分析结果
  analyzer.print_results
end