module APIGatewayDSL
  class ResponseHeader
    class Collection < Array

      def as_json
        index_by(&:name).transform_values(&:as_json)
      end

    end
  end
end
