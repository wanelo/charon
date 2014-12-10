require 'simplecov'
require 'em-spec/rspec'
require 'lapine/test/rspec_helper'
require 'pry'

require 'charon/settings'
Charon::Settings.source File.expand_path('../../config/charon.yml', __FILE__)
require 'charon'

SimpleCov.start

pid = Process.pid
SimpleCov.at_exit do
  SimpleCov.result.format! if Process.pid == pid
end

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
$LOAD_PATH << File.expand_path('../../bin/lib', __FILE__)

require File.expand_path('../fixtures.rb', __FILE__)
require File.expand_path('../resources.rb', __FILE__)
require File.expand_path('../helpers.rb', __FILE__)

include Charon::Test
include Charon::Test::Helpers

RSpec.configure do |c|
  c.include EM::SpecHelper
  c.include Lapine::Test::RSpecHelper, fake_rabbit: true

  c.before :each, :fake_rabbit do |example|
    Lapine::Test::RSpecHelper.setup(example)
    Charon::Message.initialize_lapine
  end

  c.after :each, :fake_rabbit do
    Lapine::Test::RSpecHelper.teardown
  end

  c.before :each do
    Charon.logger = Logger.new('/dev/null')
  end
end
