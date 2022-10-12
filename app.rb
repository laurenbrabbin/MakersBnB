require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_params'
require_relative 'lib/booking_repository'
require_relative 'lib/user_repository'
require_relative 'lib/host_params'
require_relative 'lib/host'

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

 #post '/host/register' do
  #  host = Host.host_create(username: params[:username], password: params[:password])
  #  return erb(:host_created)
# end

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

  get '/bookings' do
    repo = BookingRepository.new
    @bookings = repo.all
    return erb(:bookings)
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all

    return erb(:view_spaces)
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
    params[:new_name] == "" || params[:new_name] == nil || params[:new_username] == "" || params[:new_username] == nil || params[:new_email] == "" || params[:new_email] == nil || params[:new_password] == "" || params[:new_password] == nil 
  end

  def create_host
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