class Offer

  include ActiveModel::Model
  include ActiveModel::Validations
  extend ActiveModel::Callbacks
  define_model_callbacks :create

  attr_accessor :airline_code, :route_origin, :route_destination, :date_departure, :date_return, :base_price, :fare_currency, :datetime_expiration, :taxes_applicable

  validates_presence_of :airline_code, :route_origin, :route_destination

  before_create :set_expiration, :set_calculated_price

  def initialize(hash)
    super(hash)
    create # Trigger create method to enable create callback
  end

  def create
    run_callbacks :create
  end

  # Class methods

  def self.fetch_by_ond_and_dates(origin, destination, date_departure, date_return = nil)
    offers_query = Route.joins(:fares, :airline).select('routes.*, fares.*, airlines.code as airline_code').where(origin: origin, destination: destination)
    offers_results = []
    offers_query.each{|offer|
      offers_results << Offer.new(
                                  airline_code: offer.airline_code,
                                  route_origin: offer.origin,
                                  route_destination: offer.destination,
                                  date_departure: date_departure, # Offer dates are now fake
                                  date_return: date_return, #Offer dates are now fake
                                  base_price: offer.base_price,
                                  fare_currency: offer.currency,
                                  taxes_applicable: offer.taxes_applicable,
                                )
    }
    return offers_results
  end

  def taxes_price
    base_price * taxes_applicable
  end

  def base_price_with_taxes
    base_price + taxes_price
  end

  private

  def set_expiration
    self.datetime_expiration = Chronic.parse('in 24 hours')
  end

  def set_calculated_price
    self.base_price = base_price * 1.5
  end

end
