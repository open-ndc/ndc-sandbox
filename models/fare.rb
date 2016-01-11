class Fare < ActiveRecord::Base

  belongs_to :route

  JOIN_COLUMNS = ['service_class', 'currency', 'base_price', 'range_days_increase', 'rate_increase', 'taxes_applicable']

  def taxes_price
    base_price * taxes_applicable
  end

  def base_price_with_taxes
    base_price + taxes_price
  end

end
