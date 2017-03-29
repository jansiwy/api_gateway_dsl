module APIGatewayDSL
  module DSL
    class DocumentNode < BasicObject

      attr_accessor :context

      def initialize(document, &block)
        @document = document
        instance_eval(&block) if block
      end

      # General

      def title(value)
        @document.title = value
      end

      def version(value)
        @document.version = value
      end

      def description(value)
        @document.description = value
      end

      def host(value)
        @document.host = value
      end

      def schemes(*values)
        @document.schemes = values
      end

      # Operations

      %w( ANY DELETE GET OPTIONS PATCH POST PUT ).each do |method|
        class_eval <<-END_OF_RUBY, __FILE__, __LINE__ + 1
          def #{method}(path, **options, &block)
            @document.operations << Operation.new(context, "#{method}", path, **options, &block)
          end
        END_OF_RUBY
      end

    end
  end
end
