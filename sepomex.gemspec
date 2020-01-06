$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "sepomex/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "sepomex_client"
  spec.version     = SEPOMEX::VERSION
  spec.date        = '2019-12-10'
  spec.description = "SEPOMEX is a ruby integration to SEPOMEX clients for zip code information gathering"
  spec.summary     = "SEPOMEX is a library that integrates to multiple SEPOMEX clients for MX zip code information gathering"
  spec.files       = ["lib/sepomex.rb"]
  spec.authors     = ["Yellowme"]
  spec.email       = 'hola@yellowme.mx'
  spec.homepage    = 'https://github.com/yellowme/sepomex-ruby'
  spec.license      = 'MIT'

  spec.add_dependency "sepomex_acrogenesis", "~> 0.2"
  spec.add_dependency 'sepomex_hckdrk', "~> 0.1"

  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "webmock", "~> 3.7"
  spec.add_development_dependency "simplecov", "~> 0.17"
end
