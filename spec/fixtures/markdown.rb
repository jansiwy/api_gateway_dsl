require 'pathname'
require 'yaml'

module APIGatewayDSL
  class Generator

    def initialize(dir)
      @dir = Pathname.new(dir)

      File.open(dir.join('README.md'), 'w') do |fd|
        @fd = fd
        fixture
      end
    end

    private

    def fixture # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      puts "# #{result['info']['title']}"
      puts
      if result['info']['description']
        puts result['info']['description']
        puts
      end
      puts '## Given'
      puts
      Dir.glob(@dir.join('*.rb')).map { |f| Pathname.new(f) }.each do |file|
        file(file, false)
      end
      Dir.glob(@dir.join('*', '*.rb')).map { |f| Pathname.new(f) }.each do |file|
        file(file)
      end
      Dir.glob(@dir.join('*', '*', '*')).map { |f| Pathname.new(f) }.each do |file|
        file(file)
      end
      puts '## Generates'
      puts
      file(result_file)
    end

    def result_file
      @result_file ||= Pathname.new(@dir.join('index.yml'))
    end

    def result
      @result ||= YAML.safe_load(result_file.read)
    end

    def file(file, content = true) # rubocop:disable Metrics/MethodLength
      relative_file = file.relative_path_from(@dir)

      if content
        puts "* [`#{relative_file}`](#{relative_file})"
        puts
        puts "  ```#{file.extname[1..-1]}"
        puts file.read.gsub(/^/, '  ')
        puts '  ```'
      else
        puts "* [`#{relative_file}`](#{relative_file}) (skipped for readability)"
      end
      puts
    end

    def puts(*args)
      @fd.puts(*args)
    end

  end
end

Dir.glob('spec/fixtures/*').map { |f| Pathname.new(f) }.select(&:directory?).each do |fixture|
  APIGatewayDSL::Generator.new(fixture)
end
