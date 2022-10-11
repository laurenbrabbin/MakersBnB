require_relative './user'
require_relative './database_connection'

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

 # def create(new_user)
    # Encrypt the password to save it into the new database record.
  #  encrypted_password = BCrypt::Password.create(new_user.password)

  #  sql = '
  #    INSERT INTO users (email, password, username, name)
   #     VALUES($1, $2, $3, $4);'
   # sql_params = [
  #    new_user.email,
  #    encrypted_password, new_user.username, new_user.email]

  #  result_set = DatabaseConnection.exec_params(sql, sql_params)

  #  return nil
 # end
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
  