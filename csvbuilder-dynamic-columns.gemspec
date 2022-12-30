# frozen_string_literal: true

require_relative "lib/csvbuilder/dynamic/columns/exporter/version"

Gem::Specification.new do |spec|
  spec.name = "csvbuilder-dynamic-columns-exporter"
  spec.version = Csvbuilder::Dynamic::Columns::Exporter::VERSION
  spec.authors = ["Joel Azemar"]
  spec.email = ["joel.azemar@gmail.com"]

  spec.summary       = "Csvbuilder Dynamic Columns contain the components to handle CSV dynamic columns"
  spec.description   = "Help handle CSVs in a more efficient way"

  spec.homepage = "https://github.com/joel/csvbuilder-dynamic-columns-exporter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/joel/csvbuilder-dynamic-columns-exporter/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.2", "< 8"
  spec.add_dependency "csvbuilder-core", "~> 0.1"
  spec.add_dependency "csvbuilder-dynamic-columns-core", "~> 0.1"
  spec.add_dependency "csvbuilder-exporter", "~> 0.1"

  spec.metadata["rubygems_mfa_required"] = "true"
end
