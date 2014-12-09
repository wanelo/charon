require 'lapine'
require 'charon/settings'

module Charon
  # In order to use Charon::Messages, you must at some point call
  # Charon::Message.exchange(routing_key) unless you wish to use the
  # default exchange.
  class Message
    include Lapine::Publisher

    exchange Settings.messaging.exchange

    class << self
      def initialize_lapine
        settings = Settings.messaging
        connection = settings.rabbitmq
        Lapine.add_connection('charon-rabbitmq',
          host: connection.host,
          port: connection.port,
          user: connection.user,
          password: connection.password
        )

        Lapine.add_exchange(settings.exchange,
          durable: false,
          connection: 'charon-rabbitmq',
          type: 'topic'
        )
      end
    end

    def initialize(user, url)
      @user = user
      @url = url
    end

    def to_hash
      {
        'user' => @user,
        'url' => @url
      }
    end
  end
end
