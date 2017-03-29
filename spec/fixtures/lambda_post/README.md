# POST Endpoint with Lambda Integration

This example demonstrates how to specify a POST endpoint for the path `/pets` which integrates with a AWS Lambda
function `create_pet` as downstream service.

## Configuration

* The request accepts a header `Accept-Language` which is passed through as `$.meta.accept_language` to the Lambda
  function.
* The request accepts a request body; its value `$.pet.name` is passed through to the Lambda function.
* The endpoint responds with a `201` if the Lambda function invocation succeeds and passes through `$.location` as
  `Location` header from the Lambda function response to the client.
* The endpoint responds with a `500` if the Lambda function invocation fails.

## Given

* [`index.rb`](index.rb) (skipped for readability)

* [`pets/post.rb`](pets/post.rb)

  ```rb
  POST '/pets' do
    header 'Accept-Language'
  
    LAMBDA 'arn:aws:lambda:eu-west-1:123456789012:function:create_pet'
  
    RESPONSE 201 do
      header 'Location', integration: { response: { body: 'location' } }
    end
  
    RESPONSE 500, /\n|.*/
  end
  ```

* [`pets/request/body.vtl`](pets/request/body.vtl)

  ```vtl
  #set( $inputRoot = $input.path('$') )
  {
    "pet": {
      "name": $input.json('$.pet.name')
    }
    "meta": {
      "accept_language": "${util.escapeJavaScript($input.params('Accept-Language')).replaceAll("\\'","'")}"
    }
  }
  ```

* [`pets/request/body.yml`](pets/request/body.yml)

  ```yml
  type: "object"
  properties:
    pet:
      type: "object"
      properties:
        name:
          type: "string"
  ```

* [`pets/response/201.vtl`](pets/response/201.vtl)

  ```vtl
  {}
  ```

* [`pets/response/201.yml`](pets/response/201.yml)

  ```yml
  type: "object"
  ```

* [`pets/response/500.vtl`](pets/response/500.vtl)

  ```vtl
  {
    "message": "Something went wrong!"
  }
  ```

* [`pets/response/500.yml`](pets/response/500.yml)

  ```yml
  type: "object"
  properties:
    message:
      type: "string"
  ```

## Generates

* [`index.yml`](index.yml)

  ```yml
  swagger: "2.0"
  info:
    version: "1.2.3"
    title: "POST Endpoint with Lambda Integration"
    description: |
      This example demonstrates how to specify a POST endpoint for the path `/pets` which integrates with a AWS Lambda
      function `create_pet` as downstream service.
  
      ## Configuration
  
      * The request accepts a header `Accept-Language` which is passed through as `$.meta.accept_language` to the Lambda
        function.
      * The request accepts a request body; its value `$.pet.name` is passed through to the Lambda function.
      * The endpoint responds with a `201` if the Lambda function invocation succeeds and passes through `$.location` as
        `Location` header from the Lambda function response to the client.
      * The endpoint responds with a `500` if the Lambda function invocation fails.
  host: "api.example.com"
  schemes:
    - "https"
  paths:
    /pets:
      post:
        consumes:
          - "application/json"
        produces:
          - "application/json"
        parameters:
          - name: "Accept-Language"
            in: "header"
            required: false
            type: "string"
          - in: "body"
            name: "body"
            required: true
            schema:
              type: "object"
              properties:
                pet:
                  type: "object"
                  properties:
                    name:
                      type: "string"
        responses:
          '201':
            description: "201 response"
            schema:
              type: "object"
            headers:
              Location:
                type: "string"
          '500':
            description: "500 response"
            schema:
              type: "object"
              properties:
                message:
                  type: "string"
        x-amazon-apigateway-integration:
          responses:
            default:
              statusCode: "201"
              responseParameters:
                method.response.header.Location: "integration.response.body.location"
              responseTemplates:
                application/json: |
                  {}
            \n|.*:
              statusCode: "500"
              responseTemplates:
                application/json: |
                  {
                    "message": "Something went wrong!"
                  }
          requestTemplates:
            application/json: |
              #set( $inputRoot = $input.path('$') )
              {
                "pet": {
                  "name": $input.json('$.pet.name')
                }
                "meta": {
                  "accept_language": "${util.escapeJavaScript($input.params('Accept-Language')).replaceAll("\\'","'")}"
                }
              }
          uri: "arn:aws:apigateway:eu-west-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:123456789012:function:create_pet/invocations"
          passthroughBehavior: "WHEN_NO_TEMPLATES"
          httpMethod: "POST"
          contentHandling: "CONVERT_TO_TEXT"
          type: "aws"
  ```

