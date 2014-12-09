require 'charon/version'
require 'charon/settings'
require 'charon/message'
require 'logger'

module Charon
  class << self
    def logger=(logger)
      @logger = logger
    end

    def logger
      @logger ||= Logger.new($stdout).tap do |logger|
        logger.level = Logger.const_get(Settings.logging.level.upcase)
        logger.progname = 'charon'
        logger.formatter = ->(severity, time, progname, msg) {
          "%s %s[%d]: %5s: %s\n" % [time.iso8601, progname, $$, severity, msg]
        }
      end
    end
  end
  # Callback invoked before the CLI loads all its command modules.
  def self.before_command_load
    Charon::Message.initialize_lapine
  end

  # Callback invoked after the CLI loads all its command modules.
  def self.after_command_load
  end
end
