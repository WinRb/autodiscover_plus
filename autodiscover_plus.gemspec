# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autodiscover_plus/version'

Gem::Specification.new do |spec|
  spec.name          = "autodiscover_plus"
  spec.version       = AutodiscoverPlus::VERSION
  spec.authors       = ["Dan Wanek"]
  spec.email         = ["dan.wanek@gmail.com"]
  spec.summary       = %q{Microsoft Autodiscover Gem}
  spec.description   = %q{Microsoft Autodiscover Gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httpclient"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
