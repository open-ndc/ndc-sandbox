class FlightSegment < ActiveRecord::Base

  belongs_to :airline
  has_and_belongs_to_many :route
  has_many :cabins
  #has_and_belongs_to_many :flight_segments


  def self.available_mask(date = [])
    mask = 0
    date.each do |value, _key|
      mask = mask ^ 2 ** Date.parse(value).day
    end
    mask
  end

  def self.fetch_flight_segments_by_od(dep, dep_time, arr, arr_time)
    FlightSegment.where(departure_airport_code: dep, departure_time: dep_time, arrival_airport_code: arr, arrival_time: arr_time).first
  end
end
