# GET Endpoint with HTTP Integration

This example demonstrates how to specify a GET endpoint for the path `/pets` which integrates with an HTTP
downstream service at `https://petstore.example.com`.

## Configuration

* The request accepts a query string parameter `q` and a header `Accept-Language` which are passed through to the
  downstream service.
* The endpoint responds with a `200` if the downstream service responds with a `200` and passes through the response
  header `Content-Language` from the downstream service to the client.
* The endpoint responds with a `500` otherwise.

## Given

* [`index.rb`](index.rb) (skipped for readability)

* [`pets/get.rb`](pets/get.rb)

  ```rb
  GET '/pets' do
    query  'q'
    header 'Accept-Language'
  
    HTTP_GET 'https://petstore.example.com' do
      query  'q'
      header 'Accept-Language'
    end
  
    RESPONSE 200, /^200$/ do
      header 'Content-Language'
    end
  
    RESPONSE 500
  end
  ```

* [`pets/response/200.vtl`](pets/response/200.vtl)

  ```vtl
  $input.path('$')
  ```

* [`pets/response/200.yml`](pets/response/200.yml)

  ```yml
  type: "array"
  items:
    type: "object"
    properties: {}
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
    title: "GET Endpoint with HTTP Integration"
    description: |
      This example demonstrates how to specify a GET endpoint for the path `/pets` which integrates with an HTTP
      downstream service at `https://petstore.example.com`.
  
      ## Configuration
  
      * The request accepts a query string parameter `q` and a header `Accept-Language` which are passed through to the
        downstream service.
      * The endpoint responds with a `200` if the downstream service responds with a `200` and passes through the response
        header `Content-Language` from the downstream service to the client.
      * The endpoint responds with a `500` otherwise.
  host: "api.example.com"
  schemes:
    - "https"
  paths:
    /pets:
      get:
        produces:
          - "application/json"
        parameters:
          - name: "q"
            in: "query"
            required: false
            type: "string"
          - name: "Accept-Language"
            in: "header"
            required: false
            type: "string"
        responses:
          '200':
            description: "200 response"
            schema:
              type: "array"
              items:
                type: "object"
                properties: {}
            headers:
              Content-Language:
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
              statusCode: "500"
              responseTemplates:
                application/json: |
                  {
                    "message": "Something went wrong!"
                  }
            ^200$:
              statusCode: "200"
              responseParameters:
                method.response.header.Content-Language: "integration.response.header.Content-Language"
              responseTemplates:
                application/json: |
                  $input.path('$')
          requestParameters:
            integration.request.querystring.q: "method.request.querystring.q"
            integration.request.header.Accept-Language: "method.request.header.Accept-Language"
          uri: "https://petstore.example.com"
          passthroughBehavior: "WHEN_NO_TEMPLATES"
          httpMethod: "GET"
          contentHandling: "CONVERT_TO_TEXT"
          type: "http"
  ```

