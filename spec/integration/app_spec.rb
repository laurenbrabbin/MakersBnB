require "./spec/spec_helper.rb"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }



  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include("<title>MakersBnB</title>")
    end
  end
  context 'GET /user' do
    it 'should get the homepage' do
      response = get('/user')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1><p>Feel at home anywhere</h1></p>")
    end
  end
  context 'GET /user/login' do
    it 'should get the homepage' do
      response = get('/user/login')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1><p>Log in to your account</h1></p>")
    end
  end
end
