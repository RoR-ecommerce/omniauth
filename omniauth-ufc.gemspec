# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-ufc/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-ufc"
  gem.version       = OmniAuth::Ufc::VERSION
  gem.authors       = ["Igor Pstyga"]
  gem.email         = ["igor.pstyga@gmail.com"]
  gem.description   = %q{OmniAuth strategy for UFCFit.}
  gem.summary       = %q{OmniAuth strategy for UFCFit.}
  gem.homepage      = "https://github.com/RoR-ecommerce/ufc-omniauth"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "omniauth", "~> 1.1"
  gem.add_dependency "omniauth-oauth2", "~> 1.1"

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.13"
  gem.add_development_dependency "rack-test"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "webmock"
end
