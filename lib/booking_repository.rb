require './lib/booking.rb'

class BookingRepository
    def all
        query = "SELECT * FROM bookings;"
        params = []
        result_set = DatabaseConnection.exec_params(query, params)
        all_bookings = []
        
        result_set.each {|record| 
            booking = Booking.new
            booking.id = record["id"]
            booking.space_id = record["space_id"]
            booking.host_id = record["host_id"]
            booking.user_id  = record["user_id"]
            booking.start_date = record["start_date"]
            booking.end_date = record["end_date"]
            booking.confirmed = record["confirmed"]
            
           all_bookings << booking
        }
        return all_bookings
    end

    def request(booking)
        sql = 'INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ($1, $2, $3, $4, $5, $6)';
        params = [booking.space_id, booking.host_id, booking.user_id, booking.start_date, booking.end_date, booking.confirmed]
        DatabaseConnection.exec_params(sql, params)

    end


    private

    def date_available?()

    end


end