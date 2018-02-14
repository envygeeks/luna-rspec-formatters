# Frozen-string-literal: true
# Copyright: 2015 - 2017 Jordon Bedwell - MIT License
# Encoding: utf-8

$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
require "luna/rspec/formatters/version"

Gem::Specification.new do |spec|
  spec.email = ["jordon@envygeeks.io"]
  spec.version = Luna::Formatters::VERSION
  spec.summary = "RSpec formatters dedicated to Luna."
  spec.files = Dir["lib/**/*.rb"] + %w(LICENSE README.md Gemfile)
  spec.homepage = "https://github.com/envygeeks/luna-rspec-formatters"
  spec.description = "RSpec formatters that are dedicated to Luna."
  spec.name = "luna-rspec-formatters"
  spec.authors = ["Jordon Bedwell"]
  spec.require_paths = ["lib"]
  spec.license = "MIT"

  spec.add_dependency("rspec", ">= 3.0", "< 4.0")
  spec.add_dependency("forwardable-extended", "~> 2.6")
  spec.add_development_dependency("rubocop")
end
