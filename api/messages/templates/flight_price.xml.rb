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
                SimpleCurrencyPrice(Code: offer.fare.currency) {text offer.fare.base_price_with_taxes}
                BaseAmount(Code: offer.fare.currency) {text offer.fare.base_price}
                Taxes {
                  Total(Code: offer.fare.currency) {text offer.fare.taxes_price}
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
            ApplicableFlight {
              OriginDestinationReferences {text 'OD1'}

              offer.flight_segments.each do |fs|
              FlightSegmentReference(ref: fs.attributes["key"]) {
                ClassOfService {
                  Code fs.attributes[:COS]
                }
              }
              end
            }
        }
      }
    end
  }
}
