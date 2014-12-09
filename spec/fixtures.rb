def fixture(filename)
  File.expand_path("../fixtures/#{filename}", __FILE__)
end

module Charon::Test
  module Fixtures
    class << self
      def received_file
        fixture('user/file.txt')
      end
    end
  end
end
