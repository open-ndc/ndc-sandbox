ServicePriceRS(namespaces) {
  Document {
    Name name
    MessageVersion version
  }
  Success {}
  DataLists {
    AnonymousTravelerList{
      AnonymousTraveler(ObjectKey: "SH1"){
        PTC(Quantity: num_travelers){ text "ADT" }
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
            Total Integer(service.price_total) * Integer(num_travelers)
            PassengerReferences service.price_passanger_reference
          }
        }
      }
    }
  }
}
