# frozen_string_literal: true

require_relative "lib/cryptocompare/version"

Gem::Specification.new do |spec|
  spec.name = "cryptocompare"
  spec.version = Cryptocompare::VERSION
  spec.authors = ["Rishat"]
  spec.email = ["81845@mail.ru"]

  spec.summary = "Cryptocompare API SDK for Ruby"
  spec.homepage = "https://github.com/XaoGao/cryptocompare"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.7", ">= 2.7.4"
  spec.metadata["rubygems_mfa_required"] = "true"
end
