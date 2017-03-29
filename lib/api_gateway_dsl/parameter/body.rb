module APIGatewayDSL
  class Parameter
    class Body # does not extend Parameter, but is built from Template

      def initialize(template)
        @template = template
      end

      def as_json
        {}.tap do |result|
          result[:name]        = File.basename(@template.schema)
          result[:description] = @template.description if @template.description
          result[:in]          = 'body'
          result[:required]    = true
          result[:schema]      = @template.schema_value
        end
      end

    end
  end
end
