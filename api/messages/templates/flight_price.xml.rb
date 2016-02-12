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
<<<<<<< HEAD
                SimpleCurrencyPrice(Code: offer.fare_currency) {text offer.base_price_with_taxes.to_price}
                BaseAmount(Code: offer.fare_currency) {text offer.base_price.to_price}
                Taxes {
                  Total(Code: offer.fare_currency) {text offer.taxes_price.to_price}
=======
                SimpleCurrencyPrice(Code: offer.fare.currency) {text offer.fare.base_price_with_taxes}
                BaseAmount(Code: offer.fare.currency) {text offer.fare.base_price}
                Taxes {
                  Total(Code: offer.fare.currency) {text offer.fare.taxes_price}
>>>>>>> 3dd0e1ea9663b056fb5ae40158f18cf99a24cdab
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
<<<<<<< HEAD
          offer.flight_segments.each do |fs|
            ApplicableFlight {
              FlightSegmentReference(ref: fs.attributes["key"]) {
                ClassOfService {
                  Code fs.attributes[:COS]
                }
              }
            }
          end
=======
            ApplicableFlight {
              OriginDestinationReferences {text offer.dest_key }
              offer.flight_segments.each do |fs|
                FlightSegmentReference(ref: fs.attributes[:ref_key] + fs.list_id.to_s) {
                  ClassOfService {
                    Code offer.fare.service_class
                  }
                }
              end
            }
>>>>>>> 3dd0e1ea9663b056fb5ae40158f18cf99a24cdab
        }
      }
    end
  }
}
