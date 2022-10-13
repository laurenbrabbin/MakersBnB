require 'space_repository'
require 'space'


RSpec.describe SpaceRepository do 

  def reset_spaces_table
    seed_sql = File.read('spec/seeds_spaces.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bnb_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_spaces_table
  end

  it 'prints all spaces' do
   repo = SpaceRepository.new
    
    spaces = repo.all

    expect(spaces.length).to eq(2)
    expect(spaces.first.name).to eq('property1')
  end

  it 'create a new space' do
    repo = SpaceRepository.new

    new_space = Space.new
    new_space.name = "property3"
    new_space.description = "description3"
    new_space.price = "300"
    new_space.host_id = "3"

    repo.create(new_space)
    expect(repo.all.length).to eq(3)
    expect(repo.all.last.name).to eq('property3')
  end

  it "finds a spae by id" do
    repo = SpaceRepository.new
    space = repo.find(1)

    expect(space.id).to eq("1") 
    expect(space.name).to eq("property1")
    expect(space.description).to eq("description1")
    expect(space.price).to eq("100")
    expect(booking.host_id).to eq('1')
  end
end