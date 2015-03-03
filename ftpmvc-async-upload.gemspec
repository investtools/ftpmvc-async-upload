# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ftpmvc/async/upload/version'

Gem::Specification.new do |spec|
  spec.name          = "ftpmvc-async-upload"
  spec.version       = Ftpmvc::Async::Upload::VERSION
  spec.authors       = ["André Aizim Kelmanson"]
  spec.email         = ["akelmanson@gmail.com"]
  spec.summary       = %q{FTPMVC asynchronous upload using resque}
  spec.description   = %q{FTPMVC asynchronous upload using resque}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "resque_spec"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_dependency "ftpmvc", ">= 0.9.0"
  spec.add_dependency "resque"
  spec.add_dependency "app"
  spec.add_dependency "vfs"
end
