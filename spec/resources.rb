def resource(filename)
  File.expand_path("../resources/#{filename}", __FILE__)
end
module Charon::Test
  module Resources
  end
end
