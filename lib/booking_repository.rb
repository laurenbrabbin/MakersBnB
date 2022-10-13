require './lib/booking.rb'
require_relative './database_connection'

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

    def find(id)
        
        sql = 'SELECT * FROM bookings WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql, params)
        result = result_set[0]
        booking = Booking.new
        booking.id = result['id']
        booking.host_id = result['host_id']
        booking.space_id = result['space_id']
        booking.user_id = result['user_id']
        booking.start_date = result['start_date']    
        booking.end_date = result['end_date']
        booking.confirmed = result['confirmed']

        return booking
    end

    def request(booking)
        sql = 'INSERT INTO bookings (space_id, host_id, user_id, start_date, end_date, confirmed) VALUES ($1, $2, $3, $4, $5, $6)';
        params = [booking.space_id, booking.host_id, booking.user_id, booking.start_date, booking.end_date, booking.confirmed]
        DatabaseConnection.exec_params(sql, params)

        return booking
    end

    def available?(booking)
        # new_dates = 'SELECT space_id, start_date, end_date FROM bookings WHERE id = $1'
        all_bookings = 'SELECT space_id, start_date, end_date FROM bookings'
        # new_dates_result = DatabaseConnection.exec_params(new_dates, [booking.id])
        all_bookings_result = DatabaseConnection.exec_params(all_bookings, [])
        all_bookings_result.each do |record|
            # if record['space_id'] = booking.space_id && record['start_date'] == booking.start_date && record['end_date'] == booking.end_date
            #         p "This is record start date #{record['start_date']}"
            #         p "This is booking start date #{booking.start_date}"
            #         return false
            if record['space_id'] == booking.space_id && booking.start_date.between?(record['start_date'], record['end_date']) || booking.end_date.between?(record['start_date'], record['end_date'])
                return false
            else
                return true
                
            end
        end
    end

    def approve(booking) 
        sql = 'UPDATE bookings SET confirmed = $1 WHERE id = $2'
        result = DatabaseConnection.exec_params(sql, [booking.confirmed, booking.id])
    end
end