module APIGatewayDSL
  class Template
    class Collection < Array

      def initialize(context)
        @fallback = Template.new_if_schema_present(context)
      end

      def content_types
        currents.map(&:content_type).uniq
      end

      def current
        any? ? first : @fallback
      end

      # Array containing current or empty array
      def currents
        Array(current)
      end

      def as_json
        currents.index_by(&:content_type).transform_values(&:as_json)
      end

      def parameters
        Parameter::Collection.new.concat(currents.map(&:parameter))
      end

    end
  end
end
