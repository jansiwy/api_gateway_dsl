module APIGatewayDSL
  class Parameter
    class Path < Simple

      def initialize(name, **options)
        super

        @in       = 'path'
        @required = true
      end

    end
  end
end
