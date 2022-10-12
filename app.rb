require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_params'

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

  post '/user/register' do
    checking_params = UserParams.new(params[:new_name], params[:new_username], params[:new_email], params[:new_password])
    
    if empty_user_params? 
      erb(:empty_user_params)
    
    elsif checking_params.invaild_user_params?
      erb(:failed_user_registration)
    
    else 
      @new_user = create_user
      return erb(:user_created)
    end
  end
  
  private
  def empty_user_params?
    params[:new_name] == "" || params[:new_name] == nil || params[:new_username] == "" || params[:new_username] == nil || params[:new_email] == "" || params[:new_email] == nil || params[:new_password] == "" || params[:new_password] == nil 
  end

  def create_user
    repo = UserRepository.new
    new_user = User.new
    new_user.id = (repo.all.length + 1)
    new_user.name = params[:new_name]
    new_user.username = params[:new_username]
    new_user.email = params[:new_email]
    new_user.password = params[:new_password]

    repo.create(new_user)
    return new_user
  end
end