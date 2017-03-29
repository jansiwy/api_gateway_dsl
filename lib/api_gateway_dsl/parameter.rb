module APIGatewayDSL
  class Parameter

    def initialize(name, **options)
      @name        = name
      @description = options[:description].try(:strip_heredoc)
      @required    = !!options[:required]
    end

    def as_json
      {}.tap do |result|
        result[:name]        = @name
        result[:description] = @description if @description
        result[:in]          = @in
        result[:required]    = @required
      end
    end

  end
end

require 'api_gateway_dsl/parameter/body'
require 'api_gateway_dsl/parameter/collection'
require 'api_gateway_dsl/parameter/simple'
