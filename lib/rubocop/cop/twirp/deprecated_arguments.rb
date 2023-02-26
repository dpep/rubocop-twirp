module RuboCop
  module Cop
    module Twirp
      # Checks that Twirp::ClientResp uses keyword arguments
      # instead of positional arguments.
      #
      # @example
      #   # bad
      #   Twirp::ClientResp.new(data, error)
      #
      #   # good
      #   Twirp::ClientResp.new(data: data, error: error)
      #
      class DeprecatedArguments < Base
        RESTRICT_ON_SEND = [:new].freeze
        POSITIONAL_ARGS = [:data, :error].freeze

        def_node_matcher :pos_args?, <<~PATTERN
          (send (const (const { nil? cbase } :Twirp) :ClientResp) :new $!hash_type?+)
        PATTERN


        include RangeHelp
        extend AutoCorrector

        MSG = "Positional args are deprecated, use keyword args: " \
              "`%<class_name>s.%<method_name>s(%<kwargs>s)`"

        def on_send(node)
          # kwargs were introduced in Twirp v1.10
          return unless Gem::Version.new(::Twirp::VERSION) >= Gem::Version.new("1.10")

          return unless pos_args?(node)

          kwargs = POSITIONAL_ARGS.map.with_index do |arg, index|
            "#{arg}: #{node.arguments[index].source}"
          end.join(", ")

          message = format(
            MSG,
            class_name: node.receiver.source,
            kwargs: kwargs,
            method_name: node.method_name,
          )

          offense_range = range_between(
            node.arguments.first.source_range.begin_pos,
            node.arguments.last.source_range.end_pos
          )

          add_offense(
            offense_range,
            message: message,
          ) do |corrector|
            corrector.replace(offense_range, kwargs)
          end
        end
      end
    end
  end
end
