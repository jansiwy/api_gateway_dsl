[![Build Status](https://travis-ci.org/jansiwy/api_gateway_dsl.svg?branch=master)](https://travis-ci.org/jansiwy/api_gateway_dsl)
[![Code Climate](https://codeclimate.com/github/jansiwy/api_gateway_dsl/badges/gpa.svg)](https://codeclimate.com/github/jansiwy/api_gateway_dsl)
[![Test Coverage](https://codeclimate.com/github/jansiwy/api_gateway_dsl/badges/coverage.svg)](https://codeclimate.com/github/jansiwy/api_gateway_dsl/coverage)
[![Issue Count](https://codeclimate.com/github/jansiwy/api_gateway_dsl/badges/issue_count.svg)](https://codeclimate.com/github/jansiwy/api_gateway_dsl)

# Amazon API Gateway DSL

Ruby DSL to generate a [Amazon API Gateway](https://aws.amazon.com/api-gateway/) definition.

## Install

Install the Gem with

```bash
gem install api_gateway_dsl
```

## Usage

In order to generate a JSON or YAML representation of an Amazon API Gateway definition:

```bash
api_gateway_dsl json <dir>
```

or

```bash
api_gateway_dsl yaml <dir>
```

## Examples

There are several examples demonstrating how to specify an Amazon API Gateway definition:

* [GET Endpoint with HTTP Integration](spec/fixtures/http_get)
* [POST Endpoint with Lambda Integration](spec/fixtures/lambda_post)
* [POST Endpoint with Lambda Integration and CORS Support](spec/fixtures/lambda_post_with_cors)
* [Greedy Endpoint for any HTTP method with HTTP proxy integration](spec/fixtures/greedy_http_proxy)
* [OPTIONS Endpoint with Mock Integration](spec/fixtures/mock_options)
