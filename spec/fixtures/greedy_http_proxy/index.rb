title 'Greedy Endpoint for any HTTP method with HTTP proxy integration'
version '1.2.3'
description <<-EOS
  This example demonstrates how to specify a greedy endpoint which accepts any HTTP method for all paths below
  `/pets/*` and integrates with an HTTP downstream service at `https://petstore.example.com`.

  ## Configuration

  * Beyond the path, the request accepts a header `Accept-Language` which is passed through to the downstream service.
EOS

host 'api.example.com'
schemes 'https'
