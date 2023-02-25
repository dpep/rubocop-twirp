require_relative "lib/rubocop-twirp/version"
package = rubocop-twirp


Gem::Specification.new do |s|
  s.authors     = ["Daniel Pepper"]
  s.description = "..."
  s.files       = `git ls-files * ':!:spec'`.split("\n")
  s.homepage    = "https://github.com/dpep/rubocop-twirp"
  s.license     = "MIT"
  s.name        = File.basename(__FILE__).split(".")[0]
  s.summary     = package.to_s
  s.version     = package.const_get "VERSION"

  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
