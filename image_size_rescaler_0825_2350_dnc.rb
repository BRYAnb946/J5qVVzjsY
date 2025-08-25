# 代码生成时间: 2025-08-25 23:50:34
# image_size_rescaler.rb

# 图片尺寸批量调整器
# 此程序使用RUBY和CUBA框架来批量调整图片尺寸
# 需要安装CUBA框架和MiniMagick库
# 请确保gem 'cuba' 和 gem 'mini_magick' 已添加到Gemfile中

require 'cuba'
require 'mini_magick'
require 'ostruct'
require 'optparse'

# 定义批量调整图片尺寸的类
class ImageSizeRescaler
  # 初始化方法
  # @param source_folder [String] 源图片文件夹路径
  # @param target_folder [String] 目标文件夹路径
  # @param size [String] 目标尺寸，格式为 '宽度x高度'
  def initialize(source_folder, target_folder, size)
    @source_folder = source_folder
    @target_folder = target_folder
    @size = size
  end

  # 调整指定文件夹内的所有图片尺寸
  def rescale_images
    Dir.glob(@source_folder + '/*').each do |file_path|
      next unless File.file?(file_path)
      # 使用MiniMagick调整图片尺寸
      image = MiniMagick::Image.open(file_path)
      begin
        image.resize @size
        # 生成目标文件路径
        target_file_path = File.join(@target_folder, File.basename(file_path))
        # 保存调整后的图片
        image.write target_file_path
      rescue MiniMagick::Error => e
        puts "Error resizing #{file_path}: #{e.message}"
      end
    end
  end
end

# 设置命令行参数解析
options = OpenStruct.new
OptionParser.new do |opts|
  opts.banner = 'Usage: image_size_rescaler.rb [options]'

  opts.on('-s', '--source SOURCE_FOLDER', '源图片文件夹路径') do |src|
    options.source = src
  end

  opts.on('-t', '--target TARGET_FOLDER', '目标文件夹路径') do |tg|
    options.target = tg
  end

  opts.on('-z', '--size SIZE', '目标尺寸，格式为 