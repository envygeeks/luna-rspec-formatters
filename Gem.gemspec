require File.expand_path("../lib/luna/rspec/formatters/version.rb", __FILE__)

Gem::Specification.new do |spec|
  spec.homepage = "https://github.com/envygeeks/luna-rspec-formatters"
  spec.description = "A couple of RSpec formatters."
  spec.version = Luna::Rspec::Formatters::VERSION
  spec.email = ["envygeeks@gmail.com"]
  spec.name = "luna-rspec-formatters"
  spec.authors = ["Jordon Bedwell"]
  spec.license = "Apache 2.0"
  spec.require_paths = ["lib"]
  spec.files = Dir["lib/**/*.rb"] + %W(License Readme.md Gemfile)
  spec.summary = "A couple of RSpec formatters the way I like them."

  # --------------------------------------------------------------------------
  # Dependencies.
  # --------------------------------------------------------------------------

  spec.add_dependency("libnotify", "~> 0.8.1")
  spec.add_dependency("rspec", "~> 2.14")
  spec.add_dependency("term-ansicolor", "~> 1.2.2")
end
