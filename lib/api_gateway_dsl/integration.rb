module APIGatewayDSL
  class Integration

    attr_reader :method, :url, :mappings, :templates, :context

    def initialize(operation, *args, &_block)
      options = args.last.is_a?(Hash) ? args.last : {}

      @operation = operation

      @context = @operation.context.dup.tap { |c| c.default_body_file = 'request/body' }

      @passthrough_behavior = options[:passthrough_behavior] || 'WHEN_NO_TEMPLATES'
      @content_handling     = options[:content_handling]     || 'CONVERT_TO_TEXT'
      @credentials          = options[:credentials]

      @mappings  = Mapping::Collection.new
      @templates = Template::Collection.new(@context)
    end

    def as_json # rubocop:disable Metrics/MethodLength
      {}.tap do |result|
        if (request_parameters = mappings.as_json).present?
          result[:requestParameters] = request_parameters
        end

        result[:passthroughBehavior] = @passthrough_behavior
        result[:contentHandling]     = @content_handling

        if (request_templates = @templates.as_json).present?
          result[:requestTemplates] = request_templates
        end

        if (responses = @operation.responses.response_integrations.as_json).present?
          result[:responses] = responses
        end
      end
    end

  end
end

require 'api_gateway_dsl/integration/collection'
require 'api_gateway_dsl/integration/http'
require 'api_gateway_dsl/integration/http_proxy'
require 'api_gateway_dsl/integration/lambda'
require 'api_gateway_dsl/integration/mock'
