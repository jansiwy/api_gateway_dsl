module APIGatewayDSL
  class Integration
    class Lambda < Integration

      attr_reader :method, :url

      def initialize(_, lambda_arn, **options, &block)
        super

        @lambda_arn = lambda_arn

        DSL::IntegrationNode.new(self, &block)
      end

      def as_json
        super.tap do |result|
          result[:type]        = 'aws'
          result[:httpMethod]  = 'POST'
          result[:uri]         = uri

          result[:credentials] = @credentials if @credentials
        end
      end

      private

      # https://docs.aws.amazon.com/apigateway/api-reference/resource/integration/#uri
      def uri
        "arn:aws:apigateway:#{region}:lambda:path/2015-03-31/functions/#{@lambda_arn}/invocations"
      end

      def region
        @lambda_arn.split(':')[3]
      end

    end
  end
end
