class Aircraft < ActiveRecord::Base

  has_many :cabins
  belongs_to :flight_segment

  def self.get_aircrafts(airline)
  end

end
