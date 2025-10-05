# 代码生成时间: 2025-10-05 17:01:46
# system_monitor.rb
# A system resource monitor tool using Ruby and the CUBA framework.

require 'cuba'
require 'socket'
require 'open3'

# Define a module for SystemMonitor
module SystemMonitor
  # A class to hold system information
  class SystemInfo
    # Fetch CPU usage percentage
    def self.cpu_usage
      Open3.popen3('top -bn1 | grep "Cpu(s)"') do |stdin, stdout, stderr, wait_thr|
        cpu_usage_info = stdout.readline.strip
        cpu_usage_percentage = cpu_usage_info.scan(/[0-9]+/)[1].to_i
        cpu_usage_percentage
      end
    rescue => e
      puts "Error fetching CPU usage: #{e.message}"
      0
    end

    # Fetch memory usage information
    def self.memory_usage
      Open3.popen3('free') do |stdin, stdout, stderr, wait_thr|
        memory_usage_info = stdout.readlines[1..]
        memory_usage_info
      end
    rescue => e
      puts "Error fetching memory usage: #{e.message}"
      nil
    end

    # Fetch network usage information
    def self.network_usage(interface = 'eth0')
      Open3.popen3(