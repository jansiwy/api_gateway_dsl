module APIGatewayDSL
  class ResponseIntegration
    class Collection < Array

      def as_json
        index_by(&:regexp).transform_values(&:as_json)
      end

    end
  end
end
