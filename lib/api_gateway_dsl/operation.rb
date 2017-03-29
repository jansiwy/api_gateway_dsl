module APIGatewayDSL
  class Operation

    attr_reader :path, :cors, :parameters, :integrations, :responses, :context
    attr_accessor :summary, :description

    def initialize(context, method, path, **options, &block)
      @context = context.dup

      @method = method
      @path   = path

      @cors     = options[:cors]
      @security = options[:security]

      @parameters   = Parameter::Collection.new
      @integrations = Integration::Collection.new
      @responses    = Response::Collection.new

      DSL::OperationNode.new(self, &block)
    end

    def parameters_with_body
      Parameter::Collection.new.concat(parameters).tap do |result|
        if (integration = integrations.first)
          result.concat(integration.templates.parameters)
        end
      end
    end

    def method
      case @method
      when 'ANY' then 'x-amazon-apigateway-any-method'
      else            @method.downcase
      end
    end

    def cors_method
      @method # not downcased
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def as_json
      {}.tap do |result|
        result[:summary]     = summary                     if summary
        result[:description] = description.strip_heredoc   if description
        result[:security]    = [@security => []]           if @security

        if (produces = responses.content_types).present?
          result[:produces] = produces
        end
        result[:responses] = responses.as_json

        if (integration = integrations.first)
          if (consumes = integration.templates.content_types).present?
            result[:consumes] = consumes
          end
          if (params = parameters_with_body.as_json).present?
            result[:parameters] = params
          end
          result[:'x-amazon-apigateway-integration'] = integration.as_json
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  end
end

require 'api_gateway_dsl/operation/collection'
