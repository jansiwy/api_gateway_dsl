module APIGatewayDSL
  class ResponseHeader

    VALUE = { type: 'string' }.freeze

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def as_json
      VALUE
    end

  end
end

require 'api_gateway_dsl/response_header/collection'
