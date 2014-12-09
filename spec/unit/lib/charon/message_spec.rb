require 'charon/message'

describe Charon::Message do
  let(:user) { 'user' }
  let(:url) { 'http://url/' }
  subject { Charon::Message.new(user, url) }
  let(:expected_hash) {
    {
      'user' => user,
      'url' => url
    }
  }

  describe '#to_hash' do
    it 'returns the expected hash' do
      expect(subject.to_hash).to eq(expected_hash)
    end
  end
end
