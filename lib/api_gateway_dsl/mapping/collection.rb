module APIGatewayDSL
  class Mapping
    class Collection < Array

      def response_headers
        ResponseHeader::Collection.new.concat(map(&:response_header))
      end

      def as_json
        index_by(&:key).transform_values(&:as_json)
      end

    end
  end
end
