class Route < ActiveRecord::Base

  belongs_to :airline
  has_and_belongs_to_many :flight_segments
  has_many :fares
  has_and_belongs_to_many :services
  has_and_belongs_to_many :bundles

  def self.fetch_by_ond_and_dates(dep, arr, date_dep)
    Route.where(origin: dep, departure_time: date_dep, destination: arr)
  end
end
