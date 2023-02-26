describe RuboCop::Cop::Twirp::DeprecatedArguments, :config do
  it "registers an offense when using a positional argument" do
    expect_offense(<<~RUBY)
      Twirp::ClientResp.new(data, error)
                            ^^^^^^^^^^^ Positional args are deprecated, use keyword args: `Twirp::ClientResp.new(data: data, error: error)`
    RUBY

    expect_correction(<<~RUBY)
      Twirp::ClientResp.new(data: data, error: error)
    RUBY
  end

  it "handles :: prefix" do
    source = <<~RUBY
      ::Twirp::ClientResp.new(data, error)
    RUBY

    expect_correction(<<~RUBY, source: source)
      ::Twirp::ClientResp.new(data: data, error: error)
    RUBY
  end

  it "handles alternative argument names" do
    expect_offense(<<~RUBY)
      Twirp::ClientResp.new(dataz, errorz)
                            ^^^^^^^^^^^^^ Positional args are deprecated, use keyword args: `Twirp::ClientResp.new(data: dataz, error: errorz)`
    RUBY

    expect_correction(<<~RUBY)
      Twirp::ClientResp.new(data: dataz, error: errorz)
    RUBY
  end

  context "when using Twirp v1.9" do
    before { stub_const("Twirp::VERSION", "1.9.0") }

    it "does not register an offense" do
      expect_no_offenses(<<~RUBY)
        Twirp::ClientResp.new(data, error)
      RUBY
    end
  end

  it "does not register an offense when using keyword arguments" do
    expect_no_offenses(<<~RUBY)
      Twirp::ClientResp.new(data: data, error: error)
    RUBY
  end

  it "does not register an offense when using splat" do
    expect_no_offenses(<<~RUBY)
      Twirp::ClientResp.new(**kwargs)
    RUBY
  end
end
