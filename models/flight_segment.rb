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
end
