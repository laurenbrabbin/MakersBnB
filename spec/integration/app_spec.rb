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
      #expect(response.body).to eq("<title>MakersBnB</title>")
    end
  end
end
