module Charon
  class Error < StandardError; end
  class FileNotFound < Exception
    def initialize(path)
      super("File not found: #{path}")
    end
  end
end
