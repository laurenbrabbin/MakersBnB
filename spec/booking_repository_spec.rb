require_relative '../lib/booking.rb'
require_relative '../lib/booking_repository.rb'
require_relative '../lib/booking.rb'
require_relative '../lib/database_connection.rb'
require_relative '../lib/user_repository.rb'
require 'rainbow/refinement'
require 'BCrypt'

RSpec.describe BookingRepository do
    def reset_booking_table
        seed_sql = File.read('spec/seeds_bookings.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'bnb_test' })
        connection.exec(seed_sql)
      end
    
      before(:each) do 
        reset_booking_table
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


    it "finds a booking by booking id" do
        repo = BookingRepository.new
        booking = repo.find(1)

        expect(booking.id).to eq("1") 
        expect(booking.space_id).to eq("1")
        expect(booking.host_id).to eq("1")
        expect(booking.user_id).to eq("1")
        expect(booking.start_date).to eq('2022-01-01')
        expect(booking.end_date).to eq("2022-01-14")
        expect(booking.confirmed).to eq("yes")
    end

    context 'testing approving booking' do
        it 'testing new booking' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-03-03"
            booking.end_date = "2022-03-10"
            booking.confirmed = "no"
            repo.request(booking)
            second = repo.find(3)
            second.confirmed = 'yes'
            approve = repo.approve(second)
            updated = repo.find(3)
            expect(updated.confirmed).to eq 'yes'
        end

        it 'test existing booking' do
            repo = BookingRepository.new
            second = repo.find(2)
            second.confirmed = 'yes'
            approve = repo.approve(second)
            updated = repo.find(2)
            expect(updated.confirmed).to eq 'yes'
        end
    end

    context 'testing availability' do
        it 'testing for unavailable dates' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-01-01"
            booking.end_date = "2022-01-14"
            booking.confirmed = "no"
            repo.request(booking)
            double_booked = repo.find(3)
            expect(repo.available?(double_booked)).to eq false
        end
        it 'testing for available dates' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-04-01"
            booking.end_date = "2022-04-14"
            booking.confirmed = "no"
            repo.request(booking)
            # double_booked = repo.find(3)
            expect(repo.available?(booking)).to eq true # how to check for dates but for different space, it still returns true for this
        end

        it 'testing for occupied dates for different space' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-02-02"
            booking.end_date = "2022-02-14"
            booking.confirmed = "no"
            repo.request(booking)
            # double_booked = repo.find(3)
            expect(repo.available?(booking)).to eq true
        end

        it 'testing for middle of date range' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-01-07"
            booking.end_date = "2022-02-14"
            booking.confirmed = "no"
            repo.request(booking)
            # double_booked = repo.find(3)
            expect(repo.available?(booking)).to eq false
        end
        it 'testing for occupied start date but unoccupied end date' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-01-13"
            booking.end_date = "2022-01-28"
            booking.confirmed = "no"
            repo.request(booking)
            # double_booked = repo.find(3)
            expect(repo.available?(booking)).to eq false
        end
        it 'booking start date falls on existing end date' do
            repo = BookingRepository.new
            booking = Booking.new
            booking.space_id = "1"
            booking.host_id = "1"
            booking.user_id = "1"
            booking.start_date = "2022-01-13"
            booking.end_date = "2022-01-28"
            booking.confirmed = "no"
            repo.request(booking)
            # double_booked = repo.find(3)
            expect(repo.available?(booking)).to eq false
        end
    end

end