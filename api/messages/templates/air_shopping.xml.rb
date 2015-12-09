AirShoppingRQ(namespaces) {
  Document {
    Name name
    MessageVersion version
  }
  Success {}
  AirShoppingProcessing {}
  ShoppingResponseIDs {
    Owner owner
    ResponseID token
  }
  OffersGroup {
    AirlineOffers {
      TotalOfferQuantity_ offers_count
      Owner owner
      offers.each{|offer|
        AirlineOffer {
          OfferID(Owner: offer.airline_code){ text "OFFER-#{@@offers_iterator += 1}" }
          TimeLimits {
            OfferExpiration(Timestamp: offer.datetime_expiration.iso8601)
          }
          TotalPrice {
            DetailCurrencyPrice {
              Total(Code: offer.fare_currency) {text offer.base_price_with_taxes.to_price}
              Details {
                Detail {
                  SubTotal(Code: offer.fare_currency) {text offer.base_price.to_price}
                  Application "Base Fare"
                }
              }
              Taxes {
                Total(Code: offer.fare_currency) {text offer.taxes_price.to_price}
              }
            }
          }
        }
      }
    }
  }
}
