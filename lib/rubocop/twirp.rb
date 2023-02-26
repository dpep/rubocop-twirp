require "rubocop"
require "rubocop/twirp/version"
require "twirp"

# load cops
Dir["./cop/twirp/**/*.rb", base: __dir__].each { |f| require_relative f }
