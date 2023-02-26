rubocop-twirp
======
![Gem](https://img.shields.io/gem/dt/rubocop-twirp?style=plastic)
[![codecov](https://codecov.io/gh/dpep/rubocop-twirp/branch/main/graph/badge.svg)](https://codecov.io/gh/dpep/rubocop-twirp)

Improve your Twirp code with [RuboCop](https://github.com/bbatsov/rubocop)


## Install
```
gem install rubocop-twirp
```

Add to your Gemfile
```ruby
gem "rubocop-twirp", require: false
```

Add to .rubocop.yml
```
require: rubocop-twirp
```

## Use
Scan and fix issues
```
rubocop -r rubocop-twirp --only Twirp -A
```


Fix `Twirp::ClientResp` breaking change introduced in [Twirp v1.10](https://github.com/github/twirp-ruby/commit/4614a5fe004ca408c48ddfc813c80f3ad7bcb586). (Cop disabled by default)
```
rubocop -r rubocop-twirp --only Twirp/DeprecatedArguments -A
```


----
## Contributing

Yes please  :)

1. Fork it
1. Create your feature branch (`git checkout -b my-feature`)
1. Ensure the tests pass (`bundle exec rspec`)
1. Commit your changes (`git commit -am 'awesome new feature'`)
1. Push your branch (`git push origin my-feature`)
1. Create a Pull Request
