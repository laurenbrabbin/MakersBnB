require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_params'
require_relative 'lib/booking_repository'
require_relative 'lib/space_repository'
require_relative 'lib/user_repository'
require_relative 'lib/host_params'
require_relative 'lib/host'
require_relative 'lib/host_repository'
require_relative 'lib/host_params'
require_relative 'lib/booking'
require_relative 'lib/database_connection'


DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions, :method_override

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/booking_repository'
  end

  get '/' do
    return erb(:index)
  end

  get '/user' do
    return erb(:user_homepage)
  end

  get '/host' do
    return erb(:host_homepage)
  end

  get '/user/login' do
    return erb(:user_login)
  end

  get '/host/login' do
    return erb(:host_login)
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb(:view_spaces)
  end

  get '/space/:host_id' do
    repo = HostRepository.new
    @host = repo.find(params[:host_id])

    return erb(:new_space)
  end

  post '/space/:hostid' do
    repo = HostRepository.new
    @host = repo.find(params[:hostid])
    
    space_repo = SpaceRepository.new
    space = Space.new
    space.name = params[:space_name]
    space.description = params[:space_description]
    space.price = params[:space_price]
    space.host_id = params[:hostid]

    space_repo.create(space)

    return erb(:space_created)
  end


  post '/user/register' do
    @checking_params = UserParams.new(params[:new_name], params[:new_username], params[:new_email], params[:new_password])
    
    if empty_user_params? 
      erb(:empty_user_params)
    
    elsif @checking_params.invaild_user_params?
      erb(:failed_user_registration)
    else 
      @new_user = create_user
      return erb(:user_created)
    end
  end

  post '/host/register' do
    @checking_host_params = HostParams.new(params[:new_host_name], params[:new_host_username], params[:new_host_email], params[:new_host_password])
    
    if empty_host_params? 
    erb(:empty_host_params)
    
    elsif @checking_host_params.invaild_host_params?
    erb(:failed_host_registration)
    else 
     @new_host = create_host
     return erb(:host_created)
    end
  end

  get '/booking/:id' do
    repo = SpaceRepository.new
    @space = repo.find(params[:id])
    return erb(:make_booking)
  end

  post '/booking/:space_id' do
    space_repo = SpaceRepository.new
    @space = space_repo.find(params[:space_id])

    repo = BookingRepository.new
    booking = Booking.new
    booking.space_id = @space.id
    booking.host_id = @space.host_id
    booking.user_id = 1 #need to change 
    booking.start_date = params[:booking_start_date]
    booking.end_date = params[:booking_end_date]
    booking.confirmed = 'no'

    repo.request(booking)

    return erb(:booking_requested)
  end
  
  get '/bookings/:host' do
    repo = HostRepository.new
    @host = repo.find(params[:host])

    booking_repo = BookingRepository.new
    all_bookings = booking_repo.all
    
    @hosts_bookings = all_bookings.select do |booking|
      booking.host_id == params[:host]
    end

    return erb(:host_bookings)
  end

  get '/approve/:booking_id' do
    repo = BookingRepository.new
    @booking = repo.find(params[:booking_id])
    return erb(:approve_booking)
  end
  
  post '/approve/:booking_id' do
    repo = BookingRepository.new
    
    if params[:host_input] == yes
    @booking = repo.find(params[:booking_id])
    @booking.confirmed = yes 
    repo.approve(@booking)
    end

    return erb(:booking_confirmation)
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb(:view_spaces)
  end

  get '/new/space' do
    return erb(:new_space)
  end

  get 'hostmanager/:hostid' do
    repo = HostRepository.new
    @host = repo.find(params[:hostid])

    return erb(:host_manager)
  end

  private
  def empty_user_params?
    params[:new_name] == "" || params[:new_name] == nil || params[:new_username] == "" || params[:new_username] == nil || params[:new_email] == "" || params[:new_email] == nil || params[:new_password] == "" || params[:new_password] == nil 
  end

  def empty_host_params?
    params[:new_host_name] == "" || params[:new_host_name] == nil || params[:new_host_username] == "" || params[:new_host_username] == nil || params[:new_host_email] == "" || params[:new_host_email] == nil || params[:new_host_password] == "" || params[:new_host_password] == nil 
  end

  def create_user
    repo = UserRepository.new
    new_user = User.new
    new_user.id = (repo.all.length + 1) #look how we can remove this line so it automatically adds id
    new_user.name = params[:new_name]
    new_user.username = params[:new_username]
    new_user.email = params[:new_email]
    new_user.password = params[:new_password]

    repo.create(new_user)
    return new_user
  end

  def empty_host_params?
    params[:new_host_name] == "" || params[:new_host_name] == nil || params[:new_host_username] == "" || params[:new_host_username] == nil || params[:new_host_email] == "" || params[:new_host_email] == nil || params[:new_host_password] == "" || params[:new_host_password] == nil 
  end

  def create_host
    repo = HostRepository.new
    new_host = Host.new
    new_host.id = (repo.all.length + 1)
    new_host.name = params[:new_host_name]
    new_host.username = params[:new_host_username]
    new_host.email = params[:new_host_email]
    new_host.password = params[:new_host_password]

    repo.create(new_host)
    return new_host
  end
end
