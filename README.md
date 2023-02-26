rubocop-twirp
======
![Gem](https://img.shields.io/gem/dt/rubocop-twirp?style=plastic)
[![codecov](https://codecov.io/gh/dpep/rubocop-twirp/branch/main/graph/badge.svg)](https://codecov.io/gh/dpep/rubocop-twirp)

...

[RuboCop](https://github.com/bbatsov/rubocop)



```ruby
gem install rubocop-twirp

# or add to your Gemfile
gem "rubocop-twirp", require: false
```

Add this to your .rubocop.yml:
```
require: rubocop-twirp
```

Scan for issues
```
rubocop -r rubocop-twirp --only Twirp
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
