class FlightSegment < ActiveRecord::Base

  belongs_to :airline
  has_and_belongs_to_many :route
  has_many :cabins
  #has_and_belongs_to_many :flight_segments

  attr_accessor :segment_key, :aircraft_name, :departure_airport_name, :arrival_airport_name, :departure_date

  def self.available_mask(date = [])
    mask = 0
    date.each do |value, _key|
      mask = mask ^ 2 ** Date.parse(value).day
    end
    mask
  end

  def self.fetch_by_od(dep, dep_time, arr, arr_time, segment_key)
    fs = FlightSegment.where(departure_airport_code: dep, departure_time: dep_time, arrival_airport_code: arr, arrival_time: arr_time).first
    fs.segment_key = segment_key
    fs.aircraft_name = get_aircraft_name(fs.aircraft)
    fs.departure_airport_name = get_airport_name(fs.departure_airport_code)
    fs.arrival_airport_name = get_airport_name(fs.arrival_airport_code)
    fs
  end

  def self.get_aircraft_name(code)
    aircraft = YAML::load_file('yml_files/aircraft.yml')
    aircraft[code]["manufacturer"] + " " + aircraft[code]["model"]
  end

  def self.get_airport_name(code)
    aircraft = YAML::load_file('yml_files/airport.yml')
    aircraft[code]["name"]
  end
end
