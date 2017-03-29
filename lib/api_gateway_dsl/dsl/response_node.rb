module APIGatewayDSL
  module DSL
    class ResponseNode < BasicObject

      def initialize(response, &block)
        @response = response
        instance_eval(&block) if block
      end

      # Header Mappings

      def header(name, source = nil)
        @response.mappings << Mapping.new('method', 'response', 'header', name, source)
      end

      # Templates

      def body(**options)
        @response.templates << Template.new(@response.context, **options)
      end

    end
  end
end
