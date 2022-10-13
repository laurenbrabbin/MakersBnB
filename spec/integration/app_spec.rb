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
    end
  end
  context 'GET /host' do
    it 'should get the host homepage' do
      response = get('/host')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1><p>Start your journey of renting your home</h1></p>")
    end
  end
  context 'GET /user' do
    it 'should get the user homepage' do
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
  context 'GET /host/login' do
    it 'should get the homepage' do
      response = get('/host/login')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1><p>Log in to your host account</h1></p>")
    end
  end
  context 'GET /spaces' do
    it 'should show all the spaces' do
      response = get('/spaces')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h2> View places to stay... </h2>")
    end
  end
  context 'GET/space/:host_id' do
    it 'returns a create space page for a specic host' do
      response = get('/space/1')
      expect(response.status).to eq(200)
      expect(response.body).to include("<h2> Create a new space </h2>")
    end
  end
  context 'POST/space/:host_id' do
    it 'returns a created space page for a specic host' do
      response = post('/space/1')
      expect(response.status).to eq(200)
      expect(response.body).to include("<h3> Thank you for creating a space </h3>")
    end
  end
end
