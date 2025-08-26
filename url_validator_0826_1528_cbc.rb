# 代码生成时间: 2025-08-26 15:28:28
# url_validator.rb
# This script validates the URL link using Ruby and CUBA framework.

require 'cuba'
require 'uri'
require 'net/http'
require 'resolv'

# A simple Cuba app to validate URLs
Cuba.define do
  # Root route for the application
  on get do
    on "validate" do
      # Get the URL parameter from the query string
      url = params['url']
# NOTE: 重要实现细节

      # Validate the URL format
      if url.nil? || url.empty?
# 添加错误处理
        halt 400, "Missing URL parameter"
      end

      # Check if the URL is valid
      if url.match(URI.regexp(%w[http https])).nil?
        halt 400, "Invalid URL format"
      end

      # Perform DNS resolution to check if the domain is reachable
# 添加错误处理
      begin
        dns = Resolv::DNS.new
# 改进用户体验
        dns.getaddress(url)
      rescue Resolv::ResolvError
        halt 400, "Unable to resolve the domain"
      end

      # Attempt to connect to the URL to check if it's reachable
      begin
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == 'https')
        http.request_head('/')
      rescue SocketError => e
        halt 400, "Unable to connect to the URL: #{e.message}"
      rescue => e
        halt 500, "An error occurred: #{e.message}"
      end
# NOTE: 重要实现细节

      # If all checks pass, return success message
# TODO: 优化性能
      "URL is valid and reachable"
    end
  end
end