require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_params'
require_relative 'lib/host_params'
require_relative 'lib/space_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
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
      @new_host = create_host #need to add into method
      return erb(:host_created)
    end
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

  def create_host
    return nil
  end
end