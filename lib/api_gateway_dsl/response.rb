module APIGatewayDSL
  class Response

    attr_reader :status_code, :mappings, :templates, :context

    def initialize(operation, status_code, regexp, &block)
      @context = operation.context.dup.tap { |c| c.default_body_file = "response/#{status_code}" }

      @status_code = status_code.to_s
      @regexp      = regexp(regexp)

      @mappings  = Mapping::Collection.new
      @templates = Template::Collection.new(@context)

      DSL::ResponseNode.new(self, &block)
    end

    def content_types
      templates.content_types
    end

    def as_json
      {}.tap do |result|
        result[:description] = "#{status_code} response"

        if (headers = mappings.response_headers.as_json).present?
          result[:headers] = headers
        end

        if (template = templates.current)
          result[:schema] = template.schema_value
        end
      end
    end

    def response_integration
      ResponseIntegration.new(@regexp, status_code, mappings, templates)
    end

    private

    def regexp(value)
      case value
      when NilClass then 'default'
      when Regexp   then value.source
      else               value
      end
    end

  end
end

require 'api_gateway_dsl/response/collection'
