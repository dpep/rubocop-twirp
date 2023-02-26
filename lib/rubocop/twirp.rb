require "rubocop"
require "rubocop/twirp/version"

module RuboCop
  module Twirp
    PROJECT_ROOT = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
    CONFIG = YAML.safe_load(CONFIG_DEFAULT.read).freeze

    private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)

    # RuboCop doesn't support plugins yet, so monkey patch config
    module Inject
      def self.defaults!
        path = CONFIG_DEFAULT.to_s
        hash = ConfigLoader.send(:load_yaml_configuration, path)
        config = Config.new(hash, path).tap(&:make_excludes_absolute)
        puts "configuration from #{path}" if ConfigLoader.debug?
        config = ConfigLoader.merge_with_default(config, path)
        ConfigLoader.instance_variable_set(:@default_configuration, config)
      end
    end
  end
end

RuboCop::Twirp::Inject.defaults!

# load cops
Dir["./cop/twirp/**/*.rb", base: __dir__].each { |f| require_relative f }
