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

        def_node_matcher :twirp_type?, <<~PATTERN
          (send _ :be_a (const (const _ :Twirp) ${:ClientResp :Error}))
        PATTERN

        include RangeHelp
        extend AutoCorrector

        def on_send(node)
          twirp_type?(node) do |type|
            case type
            when :ClientResp
              msg = TWIRP_RESPONSE_MSG
              replacement = "be_a_twirp_response"
            when :Error
              msg = TWIRP_ERROR_MSG
              replacement = "be_a_twirp_error"
            else
              return
            end

            range = range_between(
              node.loc.selector.begin_pos,
              node.loc.end.end_pos,
            )

            add_offense(range, message: msg) do |corrector|
              corrector.replace(range, replacement)
            end
          end
        end
      end
    end
  end
end
