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

  context 'GET /bookings/new' do
    it "returns a booking form" do
        response = get('/bookings/new')

        expect(response.status).to eq(200)
        expect(response.body).to include('<form action="/bookings/new" method="post">')
        expect(response.body).to include('<input type="date" name="start_date" placeholder="YYYY-MM-DD"><br />')
    end
  end

  context 'Post /bookings/new' do
    it "should create a booking" do
      response = post('/bookings/new', space_id: '1', host_id: '1', user_id: '1', start_date: "2022-03-03", end_date: "2022-03-10", confirmed: "yes")

      expect(response.status).to eq(200)
     
      response = get('/bookings')
      expect(response.body).to include("2022-03-03")
    end

    it "should create a new booking in form and return confirmation page" do
      response = post('/bookings/new',space_id: '1', host_id: '1', user_id: '1', start_date: "2022-03-03", end_date: "2022-03-10", confirmed: "yes")

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Your booking has been requested</h1>')
    end
  end
end
