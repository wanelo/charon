module Charon
  # Charon::Notifier is used to notify external services that a file
  # is ready for processing.
  class Notifier
    attr_reader :routing_key

    def initialize
      super
      @routing_key = Settings.messaging.routing_key
    end

    def notify(user, url)
      Charon::Message.new(user, url).publish(routing_key)
      Charon.logger.info('Published message to exchange')
    end
  end
end
