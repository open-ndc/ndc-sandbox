class Cabin < ActiveRecord::Base

  belongs_to :flight_segment
  has_many :seats

  attr_accessor :segment_key

  def self.fetch_by_flight_segment(flight_segment_id, segment_key)
    cabins = Cabin.where(flight_segment_id: flight_segment_id).to_a
    cabins.map {|c| c.segment_key = segment_key}
    cabins
  end
end
