# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flic/version'

Gem::Specification.new do |spec|
  spec.name          = 'flic'
  spec.version       = Flic::VERSION
  spec.authors       = ['Alec Larsen']
  spec.email         = ['aleclarsen42@gmail.com']

  spec.summary       = %q{A Ruby implementation of the (Fliclib)[https://github.com/50ButtonsEach/fliclib-linux-hci/blob/master/ProtocolDocumentation.md]}
  spec.homepage      = 'https://github.com/anarchocurious/flic'
  spec.license       = 'MIT'
  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bindata', '~> 2.3'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
