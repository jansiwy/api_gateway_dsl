# OPTIONS Endpoint with Mock Integration

This example demonstrates how to specify an OPTIONS endpoint for the path `/pets` which uses a mock integration in
order to return constant values to add CORS support for the `/pets` path.

## Configuration

* The mock integration returns a `200`.
* The mock integration passes returns constant values for the `Access-Control-Allow-Headers`,
  `Access-Control-Allow-Methods`, and `Access-Control-Allow-Origin` headers which enable the CORS support.

## Given

* [`index.rb`](index.rb) (skipped for readability)

* [`pets/options.rb`](pets/options.rb)

  ```rb
  OPTIONS '/pets' do
    MOCK 200
  
    RESPONSE 200 do
      header 'Access-Control-Allow-Headers', 'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'
      header 'Access-Control-Allow-Methods', 'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'
      header 'Access-Control-Allow-Origin',  '*'
    end
  end
  ```

## Generates

* [`index.yml`](index.yml)

  ```yml
  swagger: "2.0"
  info:
    version: "1.2.3"
    title: "OPTIONS Endpoint with Mock Integration"
    description: |
      This example demonstrates how to specify an OPTIONS endpoint for the path `/pets` which uses a mock integration in
      order to return constant values to add CORS support for the `/pets` path.
  
      ## Configuration
  
      * The mock integration returns a `200`.
      * The mock integration passes returns constant values for the `Access-Control-Allow-Headers`,
        `Access-Control-Allow-Methods`, and `Access-Control-Allow-Origin` headers which enable the CORS support.
  host: "api.example.com"
  schemes:
    - "https"
  paths:
    /pets:
      options:
        responses:
          '200':
            description: "200 response"
            headers:
              Access-Control-Allow-Origin:
                type: "string"
              Access-Control-Allow-Methods:
                type: "string"
              Access-Control-Allow-Headers:
                type: "string"
        x-amazon-apigateway-integration:
          responses:
            default:
              statusCode: "200"
              responseParameters:
                method.response.header.Access-Control-Allow-Methods: "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
                method.response.header.Access-Control-Allow-Headers: "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
                method.response.header.Access-Control-Allow-Origin: "'*'"
          requestTemplates:
            application/json: |
              {
                "statusCode": 200
              }
          passthroughBehavior: "WHEN_NO_TEMPLATES"
          type: "mock"
  ```

