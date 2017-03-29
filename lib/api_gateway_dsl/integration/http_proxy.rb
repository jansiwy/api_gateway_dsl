module APIGatewayDSL
  class Integration
    class HTTPProxy < Integration

      attr_reader :method, :url

      def initialize(_, method, url, **options, &block)
        super

        @method = method
        @url    = url

        DSL::IntegrationNode.new(self, &block)
      end

      def as_json
        super.tap do |result|
          result.delete(:contentHandling)

          result[:type]                = 'http_proxy'
          result[:httpMethod]          = @method
          result[:uri]                 = @url
          result[:passthroughBehavior] = 'WHEN_NO_MATCH'
        end
      end

    end
  end
end
