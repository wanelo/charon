require 'settingslogic'

module Charon
  class Settings < Settingslogic
    source File.expand_path('../../../config/charon.yml', __FILE__)
  end
end
