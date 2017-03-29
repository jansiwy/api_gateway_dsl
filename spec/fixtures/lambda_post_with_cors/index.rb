title 'POST Endpoint with Lambda Integration and CORS Support'
version '1.2.3'
description <<-EOS
  This example is based on [`lambda_post`](../lambda_post), but in addition, it generates the `OPTIONS` endpoint for
  CORS support via the `cors: true` configuration.
EOS

host 'api.example.com'
schemes 'https'
