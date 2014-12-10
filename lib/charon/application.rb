require 'charon'
require 'charon/listener'
require 'charon/message'
require 'eventmachine'

module Charon
  class Application
    def start
      Charon::Message.initialize_lapine
      logger = Charon.logger
      logger.info('Charon starting...')
      fd = IO.sysopen(Settings.listening.pipe_path, Fcntl::O_RDONLY|Fcntl::O_NONBLOCK)
      pipe = IO.new(fd, Fcntl::O_RDONLY|Fcntl::O_NONBLOCK)

      EventMachine.run do
        listener = EM.watch(pipe, Charon::Listener)
        listener.notify_readable = true
      end
    end
  end
end

