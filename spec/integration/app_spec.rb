require "./spec/spec_helper.rb" 
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
    end
  end
  context 'GET /host' do
    it 'should get the user homepage' do
      response = get('/host')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1><p>Start your journey of renting your home</h1></p>")
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
end
