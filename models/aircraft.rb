class Aircraft < ActiveRecord::Base

  has_many :cabins
  belongs_to :flight_segment

end
