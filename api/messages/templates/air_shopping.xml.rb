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
              Total(Code: offer.fare_currency) {text offer.base_price}
            }
          }
        }
      }
    }
  }
}
