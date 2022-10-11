require 'pg'

class User
  attr_reader :username, :password, :id

  def initialize(id:, username:, password:)
    @id = id
    @username = username
    @password = password
  end
end