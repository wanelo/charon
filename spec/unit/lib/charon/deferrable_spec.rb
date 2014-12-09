require 'charon/deferrable'

class Charon::Test::TestDeferrable < Charon::ErrorRaisingDeferrable
  def doit(value)
    fail(Charon::Error.new(value))
  end
end

describe Charon::Deferrable do
  subject { Charon::Test::TestDeferrable.new }

  describe '#errback' do
    let(:expected) { 'expected' }
    before do
      @received = nil
      subject.errback { |exception| @received = exception }
    end

    it 'raises an error' do
      expect { subject.doit(expected) }.to raise_error(Charon::Error)
    end
  end
end
