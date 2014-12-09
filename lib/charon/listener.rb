require 'charon/deferrable'
require 'charon/exception'
require 'charon/publisher'
require 'charon/notifier'

module Charon
  # Charon::Listener binds to an IO object and expects to receive null-terminated
  # strings via that socket consisting of a path to a recently completed upload.
  class Listener < EventMachine::FileWatch
    def notify_readable
      data = @io.readlines
      data.each do |line|
        Charon::NfsPublisher.new(dest_path).tap do |publisher|
          publisher.callback do |user, url|
            logger.info 'running publisher callback'
            Charon::Notifier.new.notify(user, url)
          end
          publisher.publish(line.chomp)
        end
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
