AirShoppingRS(namespaces) {
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
          OfferID(Owner: offer.airline_code){ text "OFFER-#{offer.id}" }
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
          PricedOffer {
            OfferPrice(OfferItemID: offer.offer_id) {
              RequestedDate {
                PriceDetail {
                  TotalAmount {
                    SimpleCurrencyPrice(Code: offer.fare_currency) {text offer.base_price_with_taxes.to_price}
                    BaseAmount(Code: offer.fare_currency) {text offer.base_price.to_price}
                    Taxes {
                      Total(Code: offer.fare_currency) {text offer.taxes_price.to_price}
                    }
                  }
                }
                Associations {
                  AssociatedTraveler {
                    TravelerReferences offer.passengers_keys.join(' ')
                  }
                  AssociatedService {
                    BundleReference "SB1"
                  }
                }
                FareDetail {
                  FareComponent {
                    FareBasis {
                      FareBasisCode {
                        Code "EFO"
                      }
                    }
                  }
                }
              }
            }
            Associations {
              offer.flight_segments.each do |fs|
                ApplicableFlight {
                  FlightSegmentReference(ref: fs.attributes["key"]) {
                    ClassOfService {
                      Code fs.attributes[:COS]
                    }
                  }
                }
              end
            }
          }
        }
      }
    }
  }
}
