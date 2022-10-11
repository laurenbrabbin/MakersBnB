require 'pg'
require 'bcrypt'

class User
  attr_reader :username, :password, :id, :email

  def initialize(id:, username:, password:, email:)
    @id = id
    @username = username
    @password = password
    @email = email
  end

  def self.create(username:, password:, email:)
    encrypted_password = BCrypt::Password.create(password)

    result = DatabaseConnection.query
  end

end