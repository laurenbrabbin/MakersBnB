require 'bcrypt'
require 'pg'

class Host
  attr_reader :username, :password, :id

  def initialize(id:, username:, password:)
    @id = id
    @username = username
    @password = password
  end

  def self.host_create(username:, password:)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'bnb_test')
                 else
                   PG.connect(dbname: 'bnb')
                 end
    encrypted_password = BCrypt::Password.create(password)
    result = connection.exec("INSERT INTO hosts (username, password) VALUES('#{username}', '#{encrypted_password}') RETURNING id, username, password")
    Host.new(
      id: result[0]['id'],
      username: result[0]['username'],
      password: result[0]['password']
    )
  end

  def un_hashed_password(hash:)
    BCrypt::Password.new(hash)
  end

  def self.host_find(id:)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'bnb_test')
                 else
                   PG.connect(dbname: 'bnb')
                 end
    return nil unless id

    result = connection.exec("SELECT * FROM hosts WHERE id = #{id}")
    Host.new(
      id: result[0]['id'],
      username: result[0]['username'],
      password: result[0]['password']
    )
  end

  def self.authenticate_host(username:, password:) 
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'bnb_test')
                 else
                   PG.connect(dbname: 'bnb')
                 end
    result = connection.exec("SELECT * FROM hosts WHERE username = '#{username}'")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    Host.new(
      id: result[0]['id'],
      username: result[0]['username'],
      password: result[0]['password']
    )
  end
end