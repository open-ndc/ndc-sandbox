class Cabin < ActiveRecord::Base

  belongs_to :aircraft
  has_many :seats

  attr_accessor :segment_key

  def self.fetch_cabins(aircraft_code, service_class_code, segment_key)
    cabin = Cabin.joins(:aircraft).where(aircrafts: {code: aircraft_code}, cabins: {code: service_class_code}).first
    cabin.segment_key = segment_key
    cabin
  end

end
