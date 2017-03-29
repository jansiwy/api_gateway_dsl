# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'api_gateway_dsl/version'

Gem::Specification.new do |s|
  s.name          = 'api_gateway_dsl'
  s.version       = APIGatewayDSL::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'Ruby DSL to generate an Amazon API Gateway definition'
  s.email         = 'api_gateway_dsl@jansiwy.de'
  s.authors       = ['Jan Sebastian Siwy']
  s.homepage      = 'https://github.com/jansiwy/api_gateway_dsl'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.executables   = ['api_gateway_dsl']
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'activesupport', '~> 5.0'
  s.add_dependency 'thor', '~> 0.19'

  s.add_development_dependency 'rake', '~> 12.0'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'rspec-json_expectations', '~> 2.1'

  s.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
  s.add_development_dependency 'simplecov', '~> 0.14'
end
