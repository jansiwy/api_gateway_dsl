module APIGatewayDSL
  class Parameter
    class Query < Simple

      def initialize(name, **options)
        super

        @in = 'query'
      end

    end
  end
end
