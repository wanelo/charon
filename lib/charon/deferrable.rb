require 'eventmachine'
require 'charon/exception'

module Charon
  class Deferrable
    # Including EventMachine::Deferrable allows us to easily defer a sub-class
    # via EM.defer. It provides the callback and errback instance methods.
    include EventMachine::Deferrable

    def logger
      Charon.logger
    end
  end

  class ErrorRaisingDeferrable < Deferrable
    def initialize
      self.errback do |error|
        raise error
      end
    end
  end
end
