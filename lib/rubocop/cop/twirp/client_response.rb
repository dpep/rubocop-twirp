module RuboCop
  module Cop
    module Twirp
      # Use webmock-twirp to stub Twirp client responses
      # https://github.com/dpep/webmock-twirp
      #
      # @example
      #   # bad
      #   allow(MyTwirpClient).to receive(:my_rpc).and_return(Twirp::ClientResp.new(...))
      #
      #   # good
      #   stub_twirp_request(MyTwirpClient, :my_rpc).to_return(...)
      #
      class ClientResponse < Base
        RESTRICT_ON_SEND = [:new].freeze
        MSG = "Avoid constructing Twirp client responses manually. Use `stub_twirp_request` from `webmock-twirp` (https://github.com/dpep/webmock-twirp)".freeze

        def_node_matcher :client_response?, <<~PATTERN
          (send (const (const _ :Twirp) :ClientResp) :new ...)
        PATTERN

        def on_send(node)
          client_response?(node) do
            add_offense(node.loc.expression, message: MSG)
          end
        end
      end
    end
  end
end
