class Fare < ActiveRecord::Base

  belongs_to :route

  def taxes_price
    base_price * taxes_applicable
  end

  def base_price_with_taxes
    base_price + taxes_price
  end

end
