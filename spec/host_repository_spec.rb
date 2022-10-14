require 'host_repository'
require 'host'
require 'BCrypt'


RSpec.describe HostRepository do 

  def reset_hosts_table
    seed_sql = File.read('spec/seeds_hosts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_hosts_table
  end

  it 'prints all hosts' do
    repo = HostRepository.new
    
    hosts = repo.all

    expect(hosts.length).to eq(3)
    expect(hosts.first.name).to eq('host1')
  end

  it 'creates a new host' do
    repo = HostRepository.new

    new_host = Host.new
    new_host.id = '4'
    new_host.name = 'host4'
    new_host.username = 'hostusername4'
    new_host.email = 'host4@email.com'
    new_host.password = 'password4'

    repo.create(new_host)
    hosts = repo.all

    expect(hosts.length).to eq(4)
    expect(hosts.last.name).to eq('host4')
  end


  it 'finds the host by id' do
    repo = HostRepository.new

    host = repo.find("1")

    expect(host.id).to eq("1") 
    expect(host.name).to eq('host1') 
    expect(host.username).to eq('hostusername1') 
    expect(host.email).to eq('host1@email.com')
    expect(host.password).to eq('password1') 
  end

  it 'finds the host by email' do
    repo = HostRepository.new

    host = repo.find_by_email("host1@email.com")

    expect(host.id).to eq("1") 
    expect(host.name).to eq('host1') 
    expect(host.username).to eq('hostusername1') 
    expect(host.email).to eq('host1@email.com')
    expect(host.password).to eq('password1') 
  end

  it 'finds the host by email' do
    repo = HostRepository.new

    host = repo.find_by_email("host2@email.com")

    expect(host.id).to eq("2") 
    expect(host.name).to eq('host2') 
    expect(host.username).to eq('hostusername2') 
    expect(host.email).to eq('host2@email.com')
    expect(host.password).to eq('password2') 
  end

  xit 'returns true if a host logs in' do
    repo = HostRepository.new
    login_result = repo.sign_in('host2@email.com', 'password2')
    host_password = BCrypt::Password.new('password2')
    expect(login_result).to eq(true)
  end
end 