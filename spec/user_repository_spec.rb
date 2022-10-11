require 'user_repository'
require 'user'


RSpec.describe UserRepository do 

  def reset_users_table
    seed_sql = File.read('spec/seeds_users.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_users_table
  end

it 'prints all users' do
  repo = UserRepository.new
  
 users = repo.all

  expect(users.length).to eq(3)
  expect(users.first.name).to eq('user1')
end
end 
