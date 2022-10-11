require_relative './user'
require_relative './database_connection'
require 'BCrypt'

class UserRepository
  def all
    sql = 'SELECT id, name, username, email, password FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])

    users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.name = record['name']
      user.username = record['username']
      user.password = record['password']
      user.email = record['email']
      
      users << user
    end
    return users
  end

 def create(new_user)
    encrypted_password = BCrypt::Password.create(new_user.password)

    sql = '
      INSERT INTO users (id, name, username, email, password)
        VALUES($1, $2, $3, $4, $5);'
    
    sql_params = [new_user.id, new_user.name, new_user.username, new_user.email, encrypted_password]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def find_by_email(email)
    #sql = 'SELECT id, name, username, email, password FROM users WHERE username = $1'
    #sql_params = [username]
    #result_set = DatabaseConnection.exec_params(sql, sql_params)

    #record = result_set[0]

    #user = User.new
    #user.id = record['id']
    #user.name = record['name']
    #user.username = record['username']
    #user.email = record['email']
    #user.password = record['password']

    #return user
  end
 
    
  def sign_in(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?

    # Compare the submitted password with the encrypted one saved in the database
    if submitted_password == BCrypt::Password.new(user.password)
      # login success
    else
      # wrong password
    end
  end
end

#result = DatabaseConnection.query(
     # "INSERT INTO users (name, username, email, password)
     # VALUES ('#{name}', '#{username}', '#{email}', '#{encrypted_password}')
    #  RETURNING id, name, username, email, password;"
   # )
   # User.new(
   #   id: result[0]['id'],
   #   name: result[0]['name'],
   #   username: result[0]['username'],
   #   email: result[0]['email'],
   #   password: result[0]['password']
  #  )
  