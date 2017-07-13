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

  spec.add_dependency "tao_on_rails", "~> 0.9.2"
  spec.add_dependency "tao_ui", "~> 0.2.9"
  spec.add_dependency "simple_form", "~> 3.5.0"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "blade", "~> 0.7.0"
  spec.add_development_dependency "blade-sauce_labs_plugin", "~> 0.7.1"
  spec.add_development_dependency "selenium-webdriver", '~> 3.2.0'
end
