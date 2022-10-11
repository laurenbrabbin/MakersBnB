require_relative './space'
require_relative './database_connection'

class SpaceRepository
  def all
    sql = 'SELECT id, name, description, price, host_id FROM spaces;'
    result_set = DatabaseConnection.exec_params(sql, [])

    spaces = []

    result_set.each do |record|
      space = Space.new
      space.id = record['id']
      space.name = record['name']
      space.description = record['description']
      space.price = record['price']
      space.host_id = record['host_id']
      
      spaces << space
    end
    return spaces
  end
  def create(space)
    sql = '
      INSERT INTO spaces (name, description, price, host_id)
        VALUES($1, $2, $3, $4);'
      
    sql_params = [space.name, space.description, space.price,space.host_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end 
end