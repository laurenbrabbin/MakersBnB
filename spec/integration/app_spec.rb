require "./spec/spec_helper.rb" 
require "rack/test"
require_relative '../../app'
require 'json'
require 'space_repository'

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
    xit 'returns a created space page for a specic host if all params are correct' do
      response = post('/space/1',
                 space_name: 'space name',
                 space_description: 'space description',
                 space_price: 'space price',
                 hostid: '1')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h3> Thank you for creating a space </h3>")
    end
    it 'returns an error on the space page if params are empty' do
      response = post('/space/1')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h2> Create a new space </h2>")
      expect(response.body).to include("<body> * Please ensure all fields are complete")
    end
  end
  context 'POST/user/register' do
    it 'returns an sign up page if all details are correct' do
      response = post('/user/register',
            new_name: "newuser",
            new_username: "newusername",
            new_email: "checking@fakeemail.com",
            new_password: "checkingPassword1")
   
      expect(response.status).to eq(200)
      expect(response.body).to include("<h2><p>Thank you for signing up to MakerBnB!</p></h2>")
    end
    it 'lets the user know that the params cannot be empty' do
      response = post('/user/register',
            new_name: "newuser",
            new_username: "newusername",
            new_password: "checkingPassword1")
   
      expect(response.status).to eq(200)
      expect(response.body).to include("<h4> * please ensure all fields are complete </h4>")
    end
  end
  context 'POST/host/register' do
    it 'returns an sign up page if all details are correct' do
      response = post('/user/register',
            new_name: "newhost",
            new_username: "newhostusername",
            new_email: "checkinghost@fakeemail.com",
            new_password: "checkingPassword1")
   
      expect(response.status).to eq(200)
      expect(response.body).to include("<h2><p>Thank you for signing up to MakerBnB!</p></h2>")
    end
    it 'lets the host know that the params cannot be empty' do
      response = post('/host/register',
            new_host_name: "newuser",
            new_host_username: "newusername",
            new_host_password: "checkingPassword1")
   
      expect(response.status).to eq(200)
      expect(response.body).to include("<h4> * please ensure all fields are complete </h4>")
    end
  end
  context 'POST/booking/:space_id' do
    xit "returns a page that confirming the booking request" do
      response = post('/booking/1',
            booking_start_date: "2022-10-12",
            booking_end_date: "2022-10-14")
      
      expect(response.status).to eq(200)
      expect(response.body).to include("<h3> Thank you for booking . The request has been sent to the host for approval! </h3>")
    end
  end
  context 'GET/bookings/:host' do
    it 'shows the host all their unconfirmed and confirmed bookings' do
      response = get('/bookings/1')

      expect(response.status).to eq(200)
      expect(response.body).to include("<h3> Unconfirmed bookings: </h3>")
      expect(response.body).to include("<h3> Confirmed bookings: </h3>")
    end
  end
end

