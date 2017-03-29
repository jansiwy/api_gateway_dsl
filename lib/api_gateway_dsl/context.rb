module APIGatewayDSL
  class Context

    # Allows to change the current directory before loading another Ruby file,
    # so that it is possible to use relative file names (e.g. to JSON schemata) within the DSL.
    attr_accessor :current_dir, :default_body_file

    def initialize(current_dir = nil)
      @current_dir = current_dir
    end

  end
end
