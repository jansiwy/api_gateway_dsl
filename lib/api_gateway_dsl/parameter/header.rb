module APIGatewayDSL
  class Parameter
    class Header < Simple

      def initialize(name, **options)
        super

        @in = 'header'
      end

    end
  end
end
