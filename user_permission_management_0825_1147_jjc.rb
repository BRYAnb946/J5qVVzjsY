# 代码生成时间: 2025-08-25 11:47:34
# user_permission_management.rb

# 用户权限管理系统
# 使用CUBA框架实现用户权限的添加、删除、查询和更新功能

require 'cuba'
require 'cuba/api'
require 'cuba/res'
require 'cuba/cache'
require 'cuba/plugin/flash'
require 'data_mapper'
require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'dm-observer'

# 定义用户模型
class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String, :required => true, :unique_index => true
  property :password, String, :required => true, :length => 6..20
  property :role, String, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

# 定义权限模型
class Permission
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true, :unique_index => true
  property :description, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

# 定义用户权限关联模型
class UserRole
  include DataMapper::Resource
  property :id, Serial
  property :user_id, Integer, :required => true, :index => true
  property :permission_id, Integer, :required => true, :index => true
end

# 初始化CUBA应用
Cuba.define do
  # 设置数据库连接
  DataMapper.setup(:default, 'sqlite3://db/users_permissions.db')
  DataMapper.finalize
  DataMapper.auto_migrate!

  # 添加用户接口
  on 'users' do
    on post do
      # 解析JSON请求体
      user_data = request.body.read.to_hash
      
      # 验证数据
      unless user_data['username'] && user_data['password'] && user_data['role']
        status 400
        res.write 'Bad Request: Missing username, password, or role'
        next
      end
      
      # 创建新用户
      new_user = User.new(username: user_data['username'], password: user_data['password'], role: user_data['role'])
      new_user.save
      
      # 返回成功响应
      status 201
      res.write "User created with username: #{user_data['username']} and role: #{user_data['role']}"
    end
  end

  # 添加权限接口
  on 'permissions' do
    on post do
      # 解析JSON请求体
      permission_data = request.body.read.to_hash
      
      # 验证数据
      unless permission_data['name'] && permission_data['description']
        status 400
        res.write 'Bad Request: Missing name or description'
        next
      end
      
      # 创建新权限
      new_permission = Permission.new(name: permission_data['name'], description: permission_data['description'])
      new_permission.save
      
      # 返回成功响应
      status 201
      res.write "Permission created with name: #{permission_data['name']} and description: #{permission_data['description']}"
    end
  end

  # 添加用户权限接口
  on 'permissions/:permission_id/users/:user_id' do |permission_id, user_id|
    on post do
      # 查找用户和权限
      user = User.get(user_id)
      permission = Permission.get(permission_id)
      
      # 验证用户和权限存在
      unless user && permission
        status 404
        res.write 'Not Found: User or permission not found'
        next
      end
      
      # 创建新用户权限关联
      new_user_role = UserRole.new(user_id: user_id, permission_id: permission_id)
      new_user_role.save
      
      # 返回成功响应
      status 201
      res.write "User permission created for user: #{user.username} and permission: #{permission.name}"
    end
  end

  # 添加错误处理
  on default do
    res.write 'Not Found: Route not found'
    status 404
  end
end