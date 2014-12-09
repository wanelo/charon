require 'charon/publisher'
require 'fileutils'

module Charon
  # Charon::NfsPublisher
  # This is a simple "publisher" that will cp a file to a destination directory.
  class NfsPublisher < Publisher
    attr_reader :destination_prefix

    #
    def initialize(destination = Settings.publishing.nfs.dest_dir)
      @destination_prefix = destination
    end

    def publish(source_path)
      username, file = source_path.split('/')[-2..-1]
      destination_path = File.join(destination_prefix, username, file)
      destination_dir = File.dirname(destination_path)
      logger.info('Publishing file to %s' % destination_path)
      Dir.mkdir(destination_dir) unless File.directory?(destination_dir)
      FileUtils.cp(source_path, destination_path)
      succeed(username, destination_path)
    rescue => e
      logger.fatal("OMG I asploded, #{e}\n#{e.backtrace.join("\n")}")
      fail(e)
    end
  end
end
