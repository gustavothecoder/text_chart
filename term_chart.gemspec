# frozen_string_literal: true

require_relative "lib/term_chart/version"

Gem::Specification.new do |spec|
  spec.name = "term_chart"
  spec.version = TermChart::VERSION
  spec.authors = ["Gustavo Ribeiro"]
  spec.email = ["grdev@tutanota.com"]

  spec.summary = "Generate text-based charts."
  spec.homepage = "https://github.com/gustavothecoder/term_chart"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.glob("lib/podrb{.rb,/**/*}")
  spec.require_paths = ["lib"]
end
