require 'charon/deferrable'
require 'charon/exception'
require 'charon/publisher'
require 'charon/notifier'

module Charon
  # Charon::Listener binds to an IO object and expects to receive null-terminated
  # strings via that socket consisting of a path to a recently completed upload.
  class Listener < EventMachine::FileWatch
    def notify_readable
      line = @io.gets("\x00")
      return logger.warn("Unable to read data: #{line.inspect}") unless line
      data = line.match(/\u0002(\w+)\u0001(.*)\u0000/)
      return logger.warn("Unable to read data: #{data.inspect}") unless data

      Charon::NfsPublisher.new(dest_path).tap do |publisher|
        publisher.callback do |user, url|
          logger.info 'running publisher callback'
          Charon::Notifier.new.notify(user, url)
        end
        publisher.publish(data[1], data[2])
      end
    end

    def dest_path=(path)
      @dest_path = path
    end

    private

    def dest_path
      @dest_path || Settings.publishing.nfs.dest_dir
    end

    def logger
      Charon.logger
    end
  end
end
