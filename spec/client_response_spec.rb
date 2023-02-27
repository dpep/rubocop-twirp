describe RuboCop::Cop::Twirp::ClientResponse, :config do
  it "catches offenses" do
    expect_offense(<<~RUBY)
      expect(client).to receive(:my_rpc).and_return(Twirp::ClientResp.new)
                                                    ^^^^^^^^^^^^^^^^^^^^^ #{described_class::MSG}
    RUBY

    expect_offense(<<~RUBY)
      Twirp::ClientResp.new
      ^^^^^^^^^^^^^^^^^^^^^ #{described_class::MSG}
    RUBY
  end
end

