# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ap_ruby_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'ap_ruby_sdk'
  spec.version       = ApRubySdk::VERSION
  spec.authors       = ['Marjan, Nenad']
  spec.email         = ['marjan.stojanovic90@gmail.com, nenad.bozic@smartcat.io']

  spec.summary       = %q{Alternative Payments ruby gem sdk. Accept local payments from all over the world}
  spec.homepage      = 'http://www.alternativepayments.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
end
