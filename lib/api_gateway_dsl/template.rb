module APIGatewayDSL
  class Template

    attr_reader :schema, :description, :content_type

    def self.new_if_schema_present(context, **options)
      template = new(context, **options)
      template.schema_value ? template : nil
    end

    def initialize(context, **options)
      @context = context

      @schema   = options[:schema]   || @context.default_body_file
      @velocity = options[:velocity] || @context.default_body_file

      @description  = options[:description].try(:strip_heredoc)
      @content_type = options[:content_type] || 'application/json'
    end

    def as_json
      current_dir.join("#{@velocity}.vtl").read
    end

    def schema_value
      return unless current_dir

      if (file = current_dir.join("#{@schema}.json")).exist?
        JSON.parse(file.read)
      elsif (file = current_dir.join("#{@schema}.yml")).exist?
        YAML.safe_load(file.read)
      end
    end

    def parameter
      Parameter::Body.new(self)
    end

    private

    def current_dir
      @context.current_dir
    end

  end
end

require 'api_gateway_dsl/template/collection'
