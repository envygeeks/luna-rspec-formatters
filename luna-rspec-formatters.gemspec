# ----------------------------------------------------------------------------
# Frozen-string-literal: true
# Copyright: 2015 - 2016 Jordon Bedwell - MIT License
# Encoding: utf-8
# ----------------------------------------------------------------------------

require File.expand_path("../lib/luna/rspec/formatters/version.rb", __FILE__)

Gem::Specification.new do |spec|
  spec.email = ["jordon@envygeeks.io"]
  spec.version = Luna::Rspec::Formatters::VERSION
  spec.summary = "RSpec formatters dedicated to Luna."
  spec.files = Dir["lib/**/*.rb"] + %W(LICENSE README.md Gemfile)
  spec.homepage = "https://github.com/envygeeks/luna-rspec-formatters"
  spec.description = "RSpec formatters that are dedicated to Luna."
  spec.name = "luna-rspec-formatters"
  spec.authors = ["Jordon Bedwell"]
  spec.require_paths = ["lib"]
  spec.license = "MIT"

  spec.add_dependency("rspec", ">= 2.14", "< 4.0")
  spec.add_dependency("io-console", "~> 0.4")
end
