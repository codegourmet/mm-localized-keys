# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mm-localized-keys/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["codegourmet"]
  gem.email         = ["mail@codegourmet.de"]
  gem.description   = %q{Localized keys for Rails/MongoMapper models}
  gem.summary       = %q{Localized keys for Rails/MongoMapper models}
  gem.homepage      = "http://github.com/codegourmet/mm-localized-keys"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mm-localized-keys"
  gem.require_paths = ["lib"]
  gem.version       = LocalizedKeys::VERSION

  gem.add_dependency "rails", ">= 3.2.3"
  gem.add_dependency 'mongo_mapper', '>= 0.12.0'

  gem.add_development_dependency 'mongo_mapper', '>= 0.12.0'
  gem.add_development_dependency 'factory_girl', '>= 0.12.0'

  #gem.add_development_dependency 'pry'
  #gem.add_development_dependency 'pry-debugger'
end
