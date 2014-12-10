require 'charon/version'
require 'charon/settings'
require 'logger'

module Charon
  class << self
    def logger=(logger)
      @logger = logger
    end

    def logger
      $stdout.sync = true
      @logger ||= Logger.new($stdout).tap do |logger|
        logger.level = Logger.const_get(Settings.logging.level.upcase)
        logger.progname = 'charon'
        logger.formatter = ->(severity, time, progname, msg) {
          "%s %s[%d]: %5s: %s\n" % [time.iso8601, progname, $$, severity, msg]
        }
      end
    end
  end
end
