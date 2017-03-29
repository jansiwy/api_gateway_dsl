module APIGatewayDSL
  module DSL
    class OperationNode < BasicObject

      def initialize(operation, &block)
        @operation = operation
        instance_eval(&block) if block
      end

      # General

      def summary(value)
        @operation.summary = value
      end

      def description(value)
        @operation.description = value
      end

      # Parameters

      def path(name, **options)
        @operation.parameters << Parameter::Path.new(name, **options)
      end

      def query(name, **options)
        @operation.parameters << Parameter::Query.new(name, **options)
      end

      def header(name, **options)
        @operation.parameters << Parameter::Header.new(name, **options)
      end

      # Integrations

      %w( ANY DELETE GET OPTIONS PATCH POST PUT ).each do |method|
        class_eval <<-END_OF_RUBY, __FILE__, __LINE__ + 1

          def HTTP_#{method}(url, **options, &block)
            @operation.integrations << Integration::HTTP.new(@operation, "#{method}", url, **options, &block)
          end

          def HTTP_PROXY_#{method}(url, **options, &block)
            @operation.integrations << Integration::HTTPProxy.new(@operation, "#{method}", url, **options, &block)
          end

        END_OF_RUBY
      end

      def LAMBDA(lambda_arn, **options, &block) # rubocop:disable Style/MethodName
        @operation.integrations << Integration::Lambda.new(@operation, lambda_arn, **options, &block)
      end

      def MOCK(status_code, **options) # rubocop:disable Style/MethodName
        @operation.integrations << Integration::Mock.new(@operation, status_code, **options)
      end

      # Responses

      def RESPONSE(status_code, regexp = nil, &block) # rubocop:disable Style/MethodName
        @operation.responses << Response.new(@operation, status_code, regexp, &block)
      end

    end
  end
end
