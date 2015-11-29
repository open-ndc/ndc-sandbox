# OpenNDC :: NDC Sandbox

[![Join the chat at https://gitter.im/open-ndc/ndc-sandbox](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/open-ndc/ndc-sandbox?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Open-source NDC Sandbox for testing/development purposes.

This project is currently under a pre-development debate on how to approach it.

[Check out here more about the scope of this project](https://github.com/open-ndc/ndc-sandbox/wiki).

# Feature List

1. Supported NDC Messages:
  - AirShopping
  - FlightPrice
  - SeatAvailability
  - ServiceList
  - ServicePrice
  - OrderCreate
  - OrderList
  - OrderRetrieve
  - OrderCancel
  - ItinReshop


# Contribute

Any kind of software contribution, bug-report, and feedback is welcome and greatly appreciated.

# Credits

Codebase started from
[grape-skeleton](https://github.com/xurde/grape-skeleton) by [xurde](https://github.com/xurde)

# How to setup

1. Install dependencies with ```bundle install```
2. Run ```rackup``` to start a local server (by default runs on port 9292)
3. Test the API by validating a NDC payload, here is a curl example: ```curl -X POST "http://localhost:9292/api/v0/ndc" -H "Content-Type: application/xml" --data @search_payload.xml```

# Sample data

Sample data from IATA can be used with this sandbox. To use it either clone [NDCSampleMessages](https://github.com/iata-ndc/NDCSampleMessages) IATA NDC repository and use files as described in the section above or load files directly from GitHub:

```shell
curl -s "https://raw.githubusercontent.com/iata-ndc/NDCSampleMessages/master/Athena/OneWay/AirShoppingRQ%20-%20ARN-LHR%20OneWay%20with%20one%20pax.xml" | \
curl -X POST "http://localhost:9292/api/v0/ndc" -H "Content-Type: application/xml" --data @-
```
