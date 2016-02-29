SeatAvailabilityRS(namespaces) {
  Document {
    Name name
    MessageVersion version
  }
  Success {}
  cabins.each{ |cabin|
    Flights {
      FlightSegmentReferences cabin.segment_key
      Cabin {
        Code "M"
        Definition cabin.definition
        SeatDisplay {
          cabin.columns.split(",").each{ |col|
            Columns col
          }
          Rows{
            First cabin.rows_first
            Last cabin.rows_last
          }
        }
      }
    }
  }
  #DataLists {
    #FlightSegmentList flight_segment_list
  #}
  SeatList{
    seats.each{|seat|
      Seats(refs: "SV1 SV2 SV3 SV4", ListKey: seat.list_key){
        Location {
          Column seat.column
          Row{
            Number seat.row
          }
          Characteristics{
            seat.characteristic.split(",").each{ |charac|
              Characteristic{
                Code charac
              }
            }
          }
        }
      }
    }
  }
}
