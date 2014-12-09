module Charon::Test::Resources
  class Pipe
    attr_reader :reader, :writer
    def initialize
      @reader, @writer = IO.pipe
    end
  end
end
