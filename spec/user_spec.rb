require 'users'

describe '.user_create' do
  it 'creates a user' do
    user = User.user_create(username: 'user4', password 'password4')

    expect(user.username).to eq ('user4')
    expect(user.password).to eq ('password4')
  end

  it 'encrypts the password using BCrypt' do
    expect(BCrypt::Password).to receive (:create).with('password4')

    user = User.create(username: 'user4', email: 'email4@email.com', password: 'password4')
  end
end