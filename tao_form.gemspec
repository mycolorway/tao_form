# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)

require 'tao_form/version'

Gem::Specification.new do |spec|
  spec.name          = 'tao_form'
  spec.version       = TaoForm::VERSION
  spec.authors       = ['your name']
  spec.email         = ['your email']

  spec.homepage      = ''
  spec.summary       = ''
  spec.description   = ''
  spec.license       = "MIT"

  spec.files = Dir["{lib,vendor,config}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "tao_on_rails", "~> 1.0.0.beta.1"
  spec.add_dependency "tao_ui", "~> 1.0.0.beta.1"
  spec.add_dependency "simple_form", "~> 3.5.0"

  spec.add_development_dependency "sqlite3"
end
