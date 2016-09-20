# OpenNDC :: NDC Sandbox

[![Join the chat at https://gitter.im/open-ndc/ndc-sandbox](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/open-ndc/ndc-sandbox?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Open-source NDC Sandbox for testing/development purposes.

This project is currently under a pre-development debate on how to approach it.

[Check out here more about the scope of this project](https://github.com/open-ndc/ndc-sandbox/wiki).


## Features List

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


## Setup

1. Git clone this repo.
2. Install dependencies with ```bundle install```
3. Run ```rackup``` to start a local server (by default runs on port 9292)
4. Test the API by validating a NDC payload, here is a curl example: ```curl -X POST "http://localhost:9292/api/v0/ndc" -H "Content-Type: application/xml" --data @AirShopping.xml```


## Contribute

Any kind of software contribution, bug-report, and feedback is welcome and greatly appreciated.


## Credits

- Codebase started from [grape-skeleton](https://github.com/xurde/grape-skeleton) by [xurde](https://github.com/xurde)
- - Thanks to [AirGateway](http://airgateway.net) who contributed very actively to this project
- Thanks to *flyiin* who contributed actively to this project

