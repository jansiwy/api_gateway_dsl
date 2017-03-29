module APIGatewayDSL
  module DSL
    class IntegrationNode < BasicObject

      def initialize(integration, &block)
        @integration = integration
        instance_eval(&block) if block
      end

      # Parameter Mappings

      def path(name, source = nil)
        @integration.mappings << Mapping.new('integration', 'request', 'path', name, source)
      end

      def query(name, source = nil)
        @integration.mappings << Mapping.new('integration', 'request', 'query', name, source)
      end

      def header(name, source = nil)
        @integration.mappings << Mapping.new('integration', 'request', 'header', name, source)
      end

      # Templates

      def body(**options)
        @integration.templates << Template.new(@integration.context, **options)
      end

    end
  end
end
