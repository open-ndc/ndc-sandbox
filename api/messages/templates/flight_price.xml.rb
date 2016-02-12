FlightPriceRS(namespaces) {
  Document {
    Name name
    MessageVersion version
  }
  Success {}
  ShoppingResponseIDs {
    Owner owner
    ResponseID token
  }
  PricedFlightOffers {

    offers.each do |offer|

      PricedFlightOffer {
        OfferID(Owner: owner) { offer.id }
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
        TimeLimits {
          OfferExpiration(Timestamp: offer.datetime_expiration)
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
    end
  }
}
