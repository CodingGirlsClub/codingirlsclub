$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cgc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cgc"
  s.version     = Cgc::VERSION
  s.authors     = ["sundevilyang"]
  s.email       = ["kevin.wenyang@gmail.com"]
  s.homepage    = "http://www.codingirls.club/"
  s.summary     = "Cgc."
  s.description = "Cgc."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.0"
end
