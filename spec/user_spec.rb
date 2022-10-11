require 'users'

describe '.user_create' do
  it 'creates a user' do
    user = User.user_create(username: 'user1', password 'password1')

    expect(user.username).to eq ('user1')
  end
end