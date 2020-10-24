lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ftpmvc/async/upload/version'

Gem::Specification.new do |spec|
  spec.name          = 'ftpmvc-async-upload'
  spec.version       = Ftpmvc::Async::Upload::VERSION
  spec.authors       = ['André Aizim Kelmanson', 'Fabiano Martins']
  spec.email         = ['akelmanson@gmail.com']
  spec.summary       = 'FTPMVC asynchronous upload using sidekiq'
  spec.description   = 'FTPMVC asynchronous upload using sidekiq'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rspec-sidekiq', '~> 3.1.0'
  spec.add_development_dependency 'sidekiq-status', '~> 1.1.4'
  spec.add_dependency 'app'
  spec.add_dependency 'ftpmvc', '>= 0.9.0'
  spec.add_dependency 'sidekiq'
  spec.add_dependency 'vfs'
end
