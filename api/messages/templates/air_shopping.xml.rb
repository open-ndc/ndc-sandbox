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
    DataLists {
      AnonymousTravelerList{
        AnonymousTraveler(ObjectKey: "SH1"){
          PTC(Quantity: "#{num_travelers}"){ text "ADT" }
        }
      }
      ServiceBundleList {
        bundles.each{ |bundle|
          ServiceBundle(ListKey: bundle.bundle_id) {
            ItemCount bundles.count
            Associations {
              bundle.services.each{ |service|
                ServiceReference service.service_id
              }
            }
            BundleID bundle.bundle_id
            BundleName bundle.name
          }
        }
      }
      ServiceList {
        services.each{ |service|
          Service(ObjectKey: service.service_id){ 
            ServiceID(Owner: service.airline.code){ text service.id }
            Name service.name
            Encoding ""
            Descriptoins {
              Descriptoin {
                Text service.description_text
                Link service.description_link
                Media {
                  ObjectID service.description_object_id
                }
              }
            }
            Settlement {
              Method {
                Code service.settlement_code
                Definition service.settlement_definition
              }
            }
            Price {
              Total service.price_total
              PassengerReferences service.price_passanger_reference
            }
          }
        }
      }
    }
  }
}
