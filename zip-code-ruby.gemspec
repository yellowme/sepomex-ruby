$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "zip_code/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "zip-code-ruby"
  spec.version     = ZipCode::VERSION
  spec.date        = '2019-12-10'
  spec.summary     = "Zip Code is a ruby integration to SEPOMEX clients for zip code information gathering"
  spec.description = "Zip Code is a ruby integration to SEPOMEX clients for zip code information gathering"
  spec.files       = ["lib/zip_code.rb"]
  spec.authors     = ["Yellowme"]
  spec.email       = 'hola@yellowme.mx'
  spec.homepage    = 'https://github.com/yellowme/zip-code-ruby'
  spec.license      = 'MIT'

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"
end
