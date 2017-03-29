module APIGatewayDSL
  class Mapping

    # Maps Swagger parameter types to API Gateway parameter types
    TYPES = {
      'path'   => 'path',
      'query'  => 'querystring',
      'header' => 'header'
    }.freeze

    DEFAULT_SOURCE = {
      'integration' => 'method',
      'method'      => 'integration'
    }.freeze

    def initialize(destination, direction, type, name, source)
      @destination = destination
      @direction   = direction
      @type        = type
      @name        = name
      @source      = source
    end

    def key
      "#{@destination}.#{@direction}.#{type}.#{@name}"
    end

    def as_json
      case @source
      when ::NilClass
        flatten(default_source => { @direction => { type => @name } })
      when ::Symbol
        flatten(default_source => { @direction => { type => @source } })
      when ::Hash
        flatten(@source)
      else
        "'#{@source}'"
      end
    end

    def response_header
      ResponseHeader.new(@name)
    end

    private

    def type
      TYPES[@type]
    end

    def default_source
      DEFAULT_SOURCE[@destination]
    end

    def flatten(object)
      case object
      when ::Hash
        key = object.keys.first
        "#{key}.#{flatten(object[key])}"
      else
        object
      end
    end

  end
end

require 'api_gateway_dsl/mapping/collection'
