title 'GET Endpoint with HTTP Integration'
version '1.2.3'
description <<-EOS
  This example demonstrates how to specify a GET endpoint for the path `/pets` which integrates with an HTTP
  downstream service at `https://petstore.example.com`.

  ## Configuration

  * The request accepts a query string parameter `q` and a header `Accept-Language` which are passed through to the
    downstream service.
  * The endpoint responds with a `200` if the downstream service responds with a `200` and passes through the response
    header `Content-Language` from the downstream service to the client.
  * The endpoint responds with a `500` otherwise.
EOS

host 'api.example.com'
schemes 'https'
