module RuboCop
  module Cop
    module Twirp
      # Use rspec-twirp to simplify specs
      # https://github.com/dpep/rspec-twirp
      #
      # @example
      #   # bad
      #   expect(...).to be_a(Twirp::ClientResp)
      #   expect(...).to be_a(Twirp::Error)
      #
      #   # good
      #   expect(...).to be_a_twirp_response
      #   expect(...).to be_a_twirp_error
      #
      class RSpecBeA < Base
        RESTRICT_ON_SEND = [:be_a].freeze
        TWIRP_RESPONSE_MSG = "Use `be_a_twirp_response` from rspec-twirp (https://github.com/dpep/rspec-twirp)".freeze
        TWIRP_ERROR_MSG = "Use `be_a_twirp_error` from rspec-twirp (https://github.com/dpep/rspec-twirp)".freeze

        def_node_matcher :twirp_reponse?, <<~PATTERN
          (send _ :be_a (const (const _ :Twirp) :ClientResp))
        PATTERN

        def_node_matcher :twirp_error?, <<~PATTERN
          (send _ :be_a (const (const _ :Twirp) :Error))
        PATTERN

        include RangeHelp
        extend AutoCorrector

        def on_send(node)
          if twirp_reponse?(node)
            range = range_between(
              node.loc.selector.begin_pos,
              node.loc.end.end_pos,
            )

            add_offense(range, message: TWIRP_RESPONSE_MSG) do |corrector|
              corrector.replace(range, "be_a_twirp_response")
            end
          end

          if twirp_error?(node)
            range = range_between(
              node.loc.selector.begin_pos,
              node.loc.end.end_pos,
            )

            add_offense(range, message: TWIRP_ERROR_MSG) do |corrector|
              corrector.replace(range, "be_a_twirp_error")
            end
          end
        end
      end
    end
  end
end
