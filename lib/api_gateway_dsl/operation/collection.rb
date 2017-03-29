module APIGatewayDSL
  class Operation
    class Collection < Array

      ACCESS_CONTROL_ALLOW_HEADERS = %w(
        Content-Type
        Authorization
        X-Amz-Date
        X-Api-Key
        X-Amz-Security-Token
      ).freeze

      # Indexes a flat array of operarations by path and HTTP method:
      #
      # Given:
      #
      #   - operationA ( path = '/path1', method = 'get'  )
      #   - operationB ( path = '/path1', method = 'post' )
      #   - operationC ( path = '/path2', method = 'get'  )
      #
      # Result:
      #
      #   /path1:
      #     get:
      #       operationA
      #     post:
      #       operationB
      #   /path2:
      #     get:
      #       operationC
      #
      def as_json
        group_by(&:path).transform_values do |operations|
          append_cors_operation!(operations)
          operations.index_by(&:method).transform_values(&:as_json)
        end
      end

      private

      # All passed operations must have the same path
      def append_cors_operation!(operations)
        cors_enabled_ops = operations.select(&:cors)
        return if cors_enabled_ops.none?
        operations << cors_operation(operations.first.path, (cors_enabled_ops.map(&:cors_method) << 'OPTIONS').sort)
      end

      def cors_operation(path, methods)
        Operation.new(Context.new, 'OPTIONS', path) do
          MOCK 200

          RESPONSE 200 do
            header 'Access-Control-Allow-Headers', ACCESS_CONTROL_ALLOW_HEADERS.join(',')
            header 'Access-Control-Allow-Methods', methods.join(',')
            header 'Access-Control-Allow-Origin',  '*'
          end
        end
      end

    end
  end
end
