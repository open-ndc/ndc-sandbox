class Service < ActiveRecord::Base
  belongs_to :airline
  has_and_belongs_to_many :routes
  has_and_belongs_to_many :bundles

  def self.get_services(response_id)
    od = ShoppingStore.get_request(response_id)
    routes = Route.fetch_by_ond_and_dates(od["dep"], od["arr"], od["date_dep"]).first
    routes.services.load
  end
end
