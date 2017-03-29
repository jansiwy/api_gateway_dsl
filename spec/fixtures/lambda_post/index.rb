title 'POST Endpoint with Lambda Integration'
version '1.2.3'
description <<-EOS
  This example demonstrates how to specify a POST endpoint for the path `/pets` which integrates with a AWS Lambda
  function `create_pet` as downstream service.

  ## Configuration

  * The request accepts a header `Accept-Language` which is passed through as `$.meta.accept_language` to the Lambda
    function.
  * The request accepts a request body; its value `$.pet.name` is passed through to the Lambda function.
  * The endpoint responds with a `201` if the Lambda function invocation succeeds and passes through `$.location` as
    `Location` header from the Lambda function response to the client.
  * The endpoint responds with a `500` if the Lambda function invocation fails.
EOS

host 'api.example.com'
schemes 'https'
