module APIGatewayDSL
  class Document

    def self.load(dir)
      new do
        ::Dir.glob(::Pathname.new(dir).join('**', '*.rb')) do |file|
          file = ::Pathname.new(file)
          self.context = Context.new(file.dirname)
          instance_eval file.read, file.to_s, 1
        end
      end
    end

    attr_reader :operations
    attr_accessor :title, :version, :description, :host, :schemes

    def initialize(&block)
      @operations = Operation::Collection.new

      DSL::DocumentNode.new(self, &block)
    end

    def as_json # rubocop:disable Metrics/MethodLength
      {}.tap do |result|
        result[:swagger] = '2.0'

        result[:info] = {}.tap do |info|
          info[:title]       = title
          info[:version]     = version
          info[:description] = description.strip_heredoc if description
        end

        result[:host]    = host
        result[:schemes] = schemes

        result[:paths]   = operations.as_json
      end.deep_stringify_keys
    end

  end
end
