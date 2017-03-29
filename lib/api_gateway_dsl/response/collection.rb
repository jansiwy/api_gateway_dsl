module APIGatewayDSL
  class Response
    class Collection < Array

      def content_types
        flat_map(&:content_types).uniq
      end

      def response_integrations
        ResponseIntegration::Collection.new.concat(map(&:response_integration))
      end

      def as_json
        index_by(&:status_code).transform_values(&:as_json)
      end

    end
  end
end
