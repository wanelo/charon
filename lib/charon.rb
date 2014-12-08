require 'charon/version'

module Charon
  # Callback invoked before the CLI loads all its command modules.
  def self.before_command_load
  end

  # Callback invoked after the CLI loads all its command modules.
  def self.after_command_load
  end
end
