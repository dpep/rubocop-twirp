describe RuboCop::Cop::Twirp::RSpecBeA, :config do
  it "handles Twirp::ClientResp" do
    expect_offense(<<~RUBY)
      expect(res).to be_a(Twirp::ClientResp)
                     ^^^^^^^^^^^^^^^^^^^^^^^ #{described_class::TWIRP_RESPONSE_MSG}
    RUBY

    expect_correction(<<~RUBY)
      expect(res).to be_a_twirp_response
    RUBY
  end

  it "handles Twirp::Error" do
    expect_offense(<<~RUBY)
      expect(res).to be_a(Twirp::Error)
                     ^^^^^^^^^^^^^^^^^^ #{described_class::TWIRP_ERROR_MSG}
    RUBY

    expect_correction(<<~RUBY)
      expect(res).to be_a_twirp_error
    RUBY
  end

  it "handles :: prefix" do
    source = <<~RUBY
      expect(res).to be_a(::Twirp::ClientResp)
    RUBY

    expect_correction(<<~RUBY, source: source)
      expect(res).to be_a_twirp_response
    RUBY
  end

  it "does not complain about rspec-twirp" do
    expect_no_offenses(<<~RUBY)
      expect(res).to be_a_twirp_error
    RUBY
  end
end

