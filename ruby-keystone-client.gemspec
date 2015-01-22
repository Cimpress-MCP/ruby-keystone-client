# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keystone/v2_0/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-keystone-client"
  spec.version       = Keystone::V2_0::VERSION
  spec.authors       = ["Justin Karimi"]
  spec.email         = ["jkarimi@cimpress.com"]
  spec.summary       = %q{Ruby OpenStack Keystone Client (API V2.0).}
  spec.description   = %q{A Ruby-based client library to interact with the Keystone service.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
