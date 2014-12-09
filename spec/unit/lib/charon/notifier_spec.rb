require 'charon/notifier'

describe Charon::Notifier, fake_rabbit: true do
  subject { described_class.new }
  let(:exchange) { Lapine.find_exchange(Charon::Settings.messaging.exchange) }
  let!(:queue) { exchange.channel.queue.bind(exchange) }

  describe '#notify' do
    let(:user) { 'user' }
    let(:url) { 'http://url' }

    it 'publishes a Charon::Message' do
      subject.notify(user, url)
      expect(queue.message_count).to eq(1)
    end
  end
end
