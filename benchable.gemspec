# frozen_string_literal: true

require_relative "lib/benchable/version"

Gem::Specification.new do |spec|
  spec.name = "benchable"
  spec.version = Benchable::VERSION
  spec.authors = ["Matheus Richard"]
  spec.email = ["matheusrichardt@gmail.com"]

  spec.summary = "Write benchmarks without the hassle"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage = "https://github.com/MatheusRich/benchable"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/MatheusRich/benchable"
  spec.metadata["changelog_uri"] = "https://github.com/MatheusRich/benchable/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "benchmark-ips", "~> 2.8", ">= 2.8.2"
  spec.add_runtime_dependency "benchmark-memory", "~> 0.1.2"
end
