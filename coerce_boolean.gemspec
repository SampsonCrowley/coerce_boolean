$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "coerce_boolean/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "coerce_boolean"
  s.version     = CoerceBoolean::VERSION
  s.authors     = ["Sampson Crowley"]
  s.email       = ["sampsonsprojects@gmail.com"]
  s.homepage    = "https://github.com/SampsonCrowley/coerce_boolean"
  s.summary     = "ActiveRecord style Boolean cooersion"
  s.description = <<-DESC
    Adds a default #to_bool method to Object and adds
    the CoerceBoolean class to parse boolean like values

    Examples:
      - CoerceBoolean.from("false") # false
      - CoerceBoolean.from("true") # true
      - CoerceBoolean.from(1) # true
      - CoerceBoolean.from(0) # false
  DESC

  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "README.md"]

  s.add_development_dependency "activesupport", "~> 6.0"
  s.add_development_dependency "minitest", "~> 5.1"
  s.add_development_dependency 'minitest-reporters', "~> 1.4"
  s.add_development_dependency "rake", "~> 13.0"
end
