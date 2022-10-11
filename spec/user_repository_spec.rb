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

  it 'creates a new user' do
    repo = UserRepository.new

    new_user = User.new
    new_user.id = '4'
    new_user.name = 'user4'
    new_user.username = 'username4'
    new_user.email = 'email4@email.com'
    new_user.password = 'password4'

    repo.create(new_user)
    users = repo.all

    expect(users.length).to eq(4)
    expect(users.last.name).to eq('user4')
  end


  it 'finds the user by email' do
    repo = UserRepository.new

    user = repo.find_by_email("email1@email.com")

    expect(user.id).to eq("1") 
    expect(user.name).to eq('user1') 
    expect(user.username).to eq('username1') 
    expect(user.email).to eq('email1@email.com')
    expect(user.password).to eq('password1') 
  end
end 
