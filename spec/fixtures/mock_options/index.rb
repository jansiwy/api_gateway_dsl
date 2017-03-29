title 'OPTIONS Endpoint with Mock Integration'
version '1.2.3'
description <<-EOS
  This example demonstrates how to specify an OPTIONS endpoint for the path `/pets` which uses a mock integration in
  order to return constant values to add CORS support for the `/pets` path.

  ## Configuration

  * The mock integration returns a `200`.
  * The mock integration passes returns constant values for the `Access-Control-Allow-Headers`,
    `Access-Control-Allow-Methods`, and `Access-Control-Allow-Origin` headers which enable the CORS support.
EOS

host 'api.example.com'
schemes 'https'
