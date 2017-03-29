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

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'activesupport'
  s.add_dependency 'thor'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-json_expectations'

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'simplecov'
end
