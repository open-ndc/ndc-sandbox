class Service < ActiveRecord::Base
  belongs_to :airline
  has_and_belongs_to_many :routes
  has_and_belongs_to_many :bundles

  attr_accessor :segment_key

  def self.get_services(response_id)
    od = ShoppingStore.get_request(response_id)
    routes = Route.fetch_by_ond_and_dates(od["dep"], od["arr"], od["date_dep"]).first
    routes.services.load
  end

  def self.fetch_by_od(dep, arr, date_dep, segment_key)
    route = Route.fetch_by_ond_and_dates(dep, arr, date_dep).first
    services = route.services.to_a
    services.map {|s| s.segment_key = segment_key} unless segment_key.to_s.empty?
    services
  end
end
