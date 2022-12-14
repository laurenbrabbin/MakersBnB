require_relative './host'
require_relative './database_connection'
require 'BCrypt'

class HostRepository
  def all
    sql = 'SELECT id, name, username, email, password FROM hosts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    hosts = []

    result_set.each do |record|
      host = Host.new
      host.id = record['id']
      host.name = record['name']
      host.username = record['username']
      host.password = record['password']
      host.email = record['email']
      
      hosts << host
    end
    return hosts
  end

 def create(new_host)
    encrypted_password = BCrypt::Password.create(new_host.password)
    
    #can we do this without calling the id that it should be set as
    sql = '
      INSERT INTO hosts (id, name, username, email, password) 
        VALUES($1, $2, $3, $4, $5);'
    
    sql_params = [new_host.id, new_host.name, new_host.username, new_host.email, encrypted_password]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
  end

  def find_by_email(email)
    sql = 'SELECT id, name, username, email, password FROM hosts WHERE email = $1'
    sql_params = [email]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    if result_set.ntuples == 0
      return nil
    else 
      record = result_set[0]

      host = Host.new
      host.id = record['id']
      host.name = record['name']
      host.username = record['username']
      host.email = record['email']
      host.password = record['password']

      return host
    end
  end

  def find(id)
    sql = 'SELECT id, name, username, email, password FROM hosts WHERE id = $1'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    host = Host.new
    host.id = record['id']
    host.name = record['name']
    host.username = record['username']
    host.email = record['email']
    host.password = record['password']

    return host
  end
 
    
  def sign_in(email, submitted_password)
    host = find_by_email(email)
    
    if host.nil?
      return nil 
    end
   
    host_password = BCrypt::Password.new(host.password)

    if host_password == submitted_password
      return true
    else
      return false
    end
  end
end

#DatabaseConnection.connect
#repo = HostRepository.new


#new_host = repo.find_by_email('newhost@account.com')
# new_host
#password = BCrypt::Password.new(new_host.password)
#password == 'Password123'

#p repo.sign_in('newhost@account.com', 'Password123')