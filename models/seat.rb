class Seat < ActiveRecord::Base

  belongs_to :cabin

  def self.fetch_by_flight_segment(flight_segment_id)
    seats = []
    Cabin.fetch_by_flight_segment(flight_segment_id, "").each do |cabin|
      Seat.where(cabin_id: cabin.id).each do |seat|
        seats.push(seat)
      end
    end
    seats
  end
end
