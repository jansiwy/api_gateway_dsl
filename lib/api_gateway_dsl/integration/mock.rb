module APIGatewayDSL
  class Integration
    class Mock < Integration

      attr_reader :status_code, :templates

      def initialize(_, status_code, **options, &block)
        super

        @status_code = status_code

        DSL::IntegrationNode.new(self, &block)
      end

      def as_json # rubocop:disable Metrics/MethodLength
        super.tap do |result|
          result.delete(:contentHandling)

          result[:type] = 'mock'

          result[:requestTemplates] = {
            'application/json' => <<-EOS.strip_heredoc
              {
                "statusCode": #{@status_code}
              }
            EOS
          }
        end
      end

    end
  end
end
