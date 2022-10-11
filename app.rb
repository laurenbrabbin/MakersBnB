require 'sinatra/base'
require 'sinatra/reloader'

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

  get '/user/login' do
    return erb(:user_login)
  end
end