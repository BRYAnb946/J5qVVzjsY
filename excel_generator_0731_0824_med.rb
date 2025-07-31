# 代码生成时间: 2025-07-31 08:24:04
# excel_generator.rb
#
# 程序名: Excel表格自动生成器
# 功能: 使用RUBY和CUBA框架生成Excel表格

require 'cuba'
require 'roo'
require 'roo-xls'

class ExcelGenerator
  # 初始化方法，接收文件名和工作簿名称
  def initialize(file_name, sheet_name)
    @spreadsheet = Roo::Spreadsheet.open(file_name)
    @sheet = @spreadsheet.sheet(sheet_name)
  end

  # 添加一行数据到工作簿
  def add_row(data)
    # 检查传入的数据是否为数组
    raise ArgumentError, 'Data must be an array' unless data.is_a?(Array)
    
    # 将数据添加到工作簿的下一行
    @sheet.add_row(data)
  end

  # 保存Excel文件
  def save
    # 保存工作簿的更改
    @spreadsheet.write
  rescue => e
    # 错误处理，打印错误信息
    puts 'Error saving the Excel file: ' + e.message
  end

  # 关闭Excel文件
  def close
    @spreadsheet.close
  end
end

# Cuba路由配置
Cuba.define do
  # 定义根路径的GET请求，用于生成Excel文件
  on get do
    on "generate" do
      # 调用Excel生成器，生成文件
      file_name = 'example.xlsx'
      sheet_name = 'sheet1'
      data = [["Column1", "Column2"], ["Value1", "Value2"]]

      excel = ExcelGenerator.new(file_name, sheet_name)
      excel.add_row(data)
      excel.save
      excel.close

      # 返回成功响应
      res.write "Excel file generated successfully."
    end
  end
end
