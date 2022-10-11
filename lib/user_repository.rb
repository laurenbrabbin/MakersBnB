require 'user'
require 'database_connection'

class UserRepository
  def create(new_user)
    # Encrypt the password to save it into the new database record.
    encrypted_password = BCrypt::Password.create(new_user.password)

    sql = '
      INSERT INTO users (email, password, username)
        VALUES($1, $2, $3);
    '
    sql_params = [
      new_user.email,
      encrypted_password, new_user.username
    ]
  end

end