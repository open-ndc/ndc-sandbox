class Bundle < ActiveRecord::Base
  has_and_belongs_to_many :fares
  has_and_belongs_to_many :services
  has_and_belongs_to_many :routes

  def self.get_bundles(response_id)
    od = ShoppingStore.get_request(response_id)
    routes = Route.fetch_by_ond_and_dates(od["dep"], od["arr"], od["date_dep"]).first
    routes.bundles.load
  end
end
