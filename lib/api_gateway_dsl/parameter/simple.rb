module APIGatewayDSL
  class Parameter
    class Simple < Parameter

      def initialize(name, **options)
        super

        @type = options[:type] || 'string'
      end

      def as_json
        super.tap do |result|
          result[:type] = @type
        end
      end

    end
  end
end

require 'api_gateway_dsl/parameter/header'
require 'api_gateway_dsl/parameter/path'
require 'api_gateway_dsl/parameter/query'
