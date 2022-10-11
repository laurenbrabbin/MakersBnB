require_relative '../lib/booking.rb'
require_relative '../lib/booking_repository.rb'
require_relative '../lib/database_connection.rb'
require 'rainbow/refinement'

def reset_bookings_table
  seed_sql = File.read('databases/seeds_bookings.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'airbnb_test' })
  connection.exec(seed_sql)
end
  
describe BookingRepository do
    before(:each) do 
    reset_bookings_table
    end

    it "returns a list of all bookings made" do
        repo = BookingRepository.new

        bookings = repo.all
    
        expect(bookings.length).to eq 2
        expect(bookings.first.start_date).to eq("2022-01-01")
        expect(bookings.first.end_date).to eq('2022-01-14')
        expect(bookings.first.space_id).to eq("1")
    end


    it "requests a booking" do
        repository = BookingRepository.new
        booking = Booking.new
        booking.space_id = "1"
        booking.host_id = "1"
        booking.user_id = "1"
        booking.start_date = "2022-03-03"
        booking.end_date = "2022-03-10"
        booking.confirmed = "yes"
        repository.request(booking)

        all_bookings = repository.all
        last_booking = all_bookings.last
        expect(last_booking.start_date ).to eq("2022-03-03")
        expect(last_booking.end_date).to eq("2022-03-10")
        expect(last_booking.user_id).to eq("1")
    end

   












end