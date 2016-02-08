ServiceListRS(namespaces) {
  Document {
    Name name
    MessageVersion version
  }
  Success {}
  AnonymousTravelerList{
    AnonymousTraveler(ObjectKey: "SH1"){
      PTC(Quantity: "1"){ text "ADT" }
    }
  }
  DataLists {
    ServiceList {
      services.each{|service|
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
