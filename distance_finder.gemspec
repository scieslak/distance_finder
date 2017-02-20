# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'distance_finder/version'

Gem::Specification.new do |spec|
  spec.name          = "distance_finder"
  spec.version       = DistanceFinder::VERSION
  spec.authors       = ["Slawomir Cieslak"]
  spec.email         = ["scieslak@scieslak.com"]

  spec.summary       = %q{DistanceFinder gets distance between two provided locations.}
  spec.description   = %q{DistanceFinder gets distance between two provided locations using google maps API}
  spec.homepage      = "https://scieslak.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "1.1.14"
  spec.add_development_dependency "guard", "2.14"
  spec.add_development_dependency "guard-minitest", "2.4.6"
end
