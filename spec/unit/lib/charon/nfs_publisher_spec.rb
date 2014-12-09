require 'charon/publishers/nfs_publisher'

RSpec.describe Charon::NfsPublisher do
  let(:dest_path) { '/tmp' }
  let(:logger) { double('logger', fatal: true, info: true)}
  let(:source_path) { Fixtures::received_file }
  let(:destination_path) { File.join(dest_path, 'user', 'file.txt') }
  subject { Charon::NfsPublisher.new(dest_path) }

  before do
    @user = @path = nil
    subject.callback { |user, path| @user = user; @path = path }
    allow(Dir).to receive(:mkdir).and_return(true)
    allow(Charon).to receive(:logger).and_return(logger)
  end

  describe '#publish' do
    context 'when able to write' do
      it 'copies the file to the destination directory' do
        em do
          expect(Dir).to receive(:mkdir).with(File.dirname(destination_path))
          expect(FileUtils).to receive(:cp).with(source_path, destination_path).and_return(true)
          subject.publish(source_path)
          EM.add_timer(0.5) do
            expect(@user).to eq('user')
            done
          end
        end
      end
    end

    context 'when unable to write' do
      let(:dest_path) { '/table_flip_if_exists' }

      before do
        allow(subject).to receive(:fail)
      end

      it 'raises the exception via the errback' do
        subject.publish(source_path)
        expect(subject).to have_received(:fail).with(an_instance_of(Errno::ENOENT))
        expect(@user).to eq(nil)
      end

      it 'logs fatal error' do
        subject.publish(source_path)
        expect(logger).to have_received(:fatal)
      end
    end
  end
end
