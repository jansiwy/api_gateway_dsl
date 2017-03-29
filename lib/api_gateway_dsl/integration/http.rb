module APIGatewayDSL
  class Integration
    class HTTP < Integration

      attr_reader :method, :url

      def initialize(_, method, url, **options, &block)
        super

        @method = method
        @url    = url

        DSL::IntegrationNode.new(self, &block)
      end

      def as_json
        super.tap do |result|
          result[:type]       = 'http'
          result[:httpMethod] = @method
          result[:uri]        = @url
        end
      end

    end
  end
end
