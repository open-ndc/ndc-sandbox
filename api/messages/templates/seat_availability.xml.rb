SeatAvailabilityRS(namespaces) {
  Document {
    Name name
    MessageVersion version
  }
  Success {}
  flights.each{ |flight|
    Flights {
      FlightSegmentReferences 'SEG1'
      Cabin {
        Code M
      }
      Definition 'ECONOMY'
      SeatDisplay {
        columns.each{ |col|
          Columns col
        }
        Rows{
          First 3
          Last 31
        }
      }
    }
  }
  DataLists {
    FlightSegmentList {
      flight_segment_list.each { |fs|
        FlightSegment(SegmentKey: fs.object_key){
          Departure{
            AirportCode fs.airport_code
            Date fs.date
            Time fs.time
          }
          Arrival {
            AirportCode fs.arrival.airport_code
          }

        }
      }
    }
  }
}
