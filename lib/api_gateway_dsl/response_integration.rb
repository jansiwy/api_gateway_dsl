module APIGatewayDSL
  class ResponseIntegration

    attr_reader :regexp

    def initialize(regexp, status_code, mappings, templates)
      @regexp      = regexp
      @status_code = status_code
      @mappings    = mappings
      @templates   = templates
    end

    def as_json
      {}.tap do |result|
        result[:statusCode] = @status_code

        if (response_parameters = @mappings.as_json).present?
          result[:responseParameters] = response_parameters
        end

        if (response_templates = @templates.as_json).present?
          result[:responseTemplates] = response_templates
        end
      end
    end

  end
end

require 'api_gateway_dsl/response_integration/collection'
