require 'charon/settings'

class CharonApp < Thor

  desc 'Start the Charon daemon', usage: 'charon start [config.yml]'

  def start(config_path = DEFAULT_CONFIG)
    trap_signals
    Charon::Settings.source(config_path)
    require 'charon/application'
    Charon::Application.new.start
  end

  private

  DEFAULT_CONFIG = File.expand_path('../../../config/charon.yml', __FILE__)

  def trap_signals
    trap('INT') {
      EventMachine.stop_event_loop
    }

    trap('TERM') {
      EventMachine.stop_event_loop
    }
  end
end
