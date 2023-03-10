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
```yaml
require: rubocop-twirp
```

## Usage
Scan and fix issues
```
rubocop -r rubocop-twirp --only Twirp -A
```


Fix `Twirp::ClientResp` breaking change introduced in [Twirp v1.10](https://github.com/github/twirp-ruby/commit/4614a5fe004ca408c48ddfc813c80f3ad7bcb586). (Cop disabled by default)
```
rubocop -r rubocop-twirp --only Twirp/DeprecatedArguments -A
```


## Cops

#### Twirp/ClientResponse

Use [webmock-twirp](https://github.com/dpep/webmock-twirp) to stub Twirp client responses.

```ruby
# bad
allow(MyTwirpClient).to receive(:my_rpc).and_return(Twirp::ClientResp.new(...))

# good
stub_twirp_request(MyTwirpClient, :my_rpc).to_return(...)
```


#### Twirp/DeprecatedArguments
Checks that Twirp::ClientResp uses keyword arguments instead of positional arguments.  Needed for Twirp `>= 1.10`

```ruby
# bad
Twirp::ClientResp.new(data, error)

# good

Twirp::ClientResp.new(data: data, error: error)
```


#### Twirp/RSpecBeA
Use [rspec-twirp](https://github.com/dpep/rspec-twirp) to simplify specs.

```ruby
# bad
expect(...).to be_a(Twirp::ClientResp)
expect(...).to be_a(Twirp::Error)

# good
expect(...).to be_a_twirp_response
expect(...).to be_a_twirp_error
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


### Resources
- https://docs.rubocop.org/rubocop/1.46/development.html
- https://github.com/rubocop/rubocop-ast/blob/master/docs/modules/ROOT/pages/node_pattern.adoc
- https://github.com/rubocop/rubocop-performance
