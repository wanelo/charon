require 'charon/listener'
require 'charon/publishers/nfs_publisher'
require 'charon/notifier'

class CharonApp < Thor

  desc 'Start the Charon daemon', usage: 'charon start [config.yml]'

  def start(config_path = DEFAULT_CONFIG)
    trap_signals
    logger = Charon.logger
    logger.info('Charon starting...')
    config = parse_config(config_path)
    fd = IO.sysopen(config.listening.pipe_path, Fcntl::O_RDONLY|Fcntl::O_NONBLOCK)
    pipe = IO.new(fd, Fcntl::O_RDONLY|Fcntl::O_NONBLOCK)

    EventMachine.run do
      listener = EM.watch(pipe, Charon::Listener)
      listener.notify_readable = true
    end
  end

  private

  DEFAULT_CONFIG = File.expand_path('../../../config/charon.yml', __FILE__)

  def parse_config(config_path)
    @config ||= Charon::Settings.new(config_path)
  end

  def trap_signals
    trap('INT') {
      EventMachine.stop_event_loop
    }

    trap('TERM') {
      EventMachine.stop_event_loop
    }
  end

end
