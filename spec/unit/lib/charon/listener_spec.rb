require 'charon/listener'

RSpec.describe Charon::Listener do
  subject { described_class.new(0) } # Dirty hack that makes it actually initialize
  let(:publisher) { double('Charon::Publisher', callback: ->() { yield }, publish: true) }
  let(:notifier) { double('Charon::Notifier', notify: true) }
  let(:files) { ["\u0002username\u0001file1.txt\u0000", "\u0002username\u0001file2.txt\u0000"].join }
  let(:pipe) { Resources::Pipe.new }
  let(:reader) { pipe.reader }
  let(:writer) { pipe.writer }


  describe '#notify_readable' do
    before do
      allow(Charon::NfsPublisher).to receive(:new).and_return(publisher)
      allow_any_instance_of(Logger).to receive(:info)
      allow(Charon::Notifier).to receive(:new).and_return(notifier)
      subject.instance_variable_set(:@io, reader)
      writer.write(files)
    end

    it 'parses null-terminated strings' do
      subject.notify_readable
      subject.notify_readable
      expect(publisher).to have_received(:publish).with('username', 'file1.txt').once
      expect(publisher).to have_received(:publish).with('username', 'file2.txt').once
    end
  end
end
