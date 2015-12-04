class FlightSegment < ActiveRecord::Base

  belongs_to :airline
  has_and_belongs_to_many :flight_segments

end
