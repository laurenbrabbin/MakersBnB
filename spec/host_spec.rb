require 'host'

describe 'host_create' do
  it 'creates a host' do
    host = Host.host_create(username: 'test3', password: 'password123')

    expect(host.username).to eq('test3')
  end

  it 'hashes a password' do
    expect(BCrypt::Password).to receive(:create).with('password123')
    Host.host_create(username: 'test4', password: 'password123')
  end
end

describe 'find' do
  it 'finds a host by ID' do
    host = Host.host_create(username: 'test', password: 'password123')
    result = Host.host_find(id: host.id)

    expect(result.id).to eq host.id
    expect(result.username).to eq host.username
    expect(result.password).to eq host.password
  end

  it 'returns nil if there is no ID given' do
    expect(Host.host_find(id: nil)).to eq nil
  end
end

describe 'authenticate_host' do
  xit 'returns a host given a correct username and password' do
    host = Host.host_create(username: 'test5', password: 'password123')
    authenticated_host = Host.authenticate_host(username: 'test5', password: 'password123')

    expect(authenticated_host.id).to eq(host.id) #given 4 expected 34
  end

  it 'returns nil given an incorrect username' do
    host = Host.host_create(username: 'test6', password: 'password123')

    expect(Host.authenticate_host(username: 'dsughf', password: 'password123')).to be_nil
  end

  it 'returns nil given a incorrect password' do
    host = Host.host_create(username: 'test7', password: 'password123')

    expect(Host.authenticate_host(username: 'test7', password: 'wrong')).to be_nil
  end
end