require_relative "lib/rubocop/twirp/version"

Gem::Specification.new do |s|
  s.authors     = ["Daniel Pepper"]
  s.description = <<~DESCRIPTION
    RuboCop cops for Twirp client code: flag deprecated positional
    arguments to Twirp::ClientResp, encourage webmock-twirp stubs
    over ad-hoc mocks, and steer expectations toward rspec-twirp
    matchers.
  DESCRIPTION
  s.files       = `git ls-files * ':!:spec'`.split("\n")
  s.homepage    = "https://github.com/dpep/rubocop-twirp"
  s.license     = "MIT"
  s.name        = "rubocop-twirp"
  s.summary     = "RuboCop::Twirp"
  s.version     = RuboCop::Twirp::VERSION

  s.required_ruby_version = ">= 3"

  s.add_dependency "rubocop", ">= 1"

  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
