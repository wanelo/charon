require 'charon/listener'

RSpec.describe Charon::Listener, eventmachine: true do
  subject { EM.watch(pipe, Charon::Listener) }
  let(:fd) { IO.sysopen('/tmp/charon.pipe', Fcntl::O_RDWR|Fcntl::O_NONBLOCK) }
  let(:pipe) { IO.new(fd, Fcntl::O_RDWR|Fcntl::O_NONBLOCK) }
  let(:received_file) { "#{Fixtures::received_file}\n" }
  let(:dest_path) { File.join('/tmp/charon', 'user', File.basename(received_file)) }

  describe '#notify_readable' do
    before do
      system('mkfifo /tmp/charon.pipe')
      FileUtils.mkdir_p('/tmp/charon')
    end

    after do
      system('rm /tmp/charon.pipe')
      Dir.rmdir('/tmp/charon')
    end

    # XXX: Disabled, because reasons... i.e. we don't know how to do this yet.
    #      EventMachine runs, data is written to pipe but callbacks are not fired.
    xit 'publishes the data' do
      EventMachine.run do
        subject.dest_path = '/tmp/charon'
        subject.notify_readable = true

        EM.add_timer(1) {
          pipe.write(received_file)
        }

        EM.add_timer(2) {
          EventMachine.stop_event_loop
        }
      end

      expect(File.exist?('/tmp/charon/file.txt')).to be true
    end
  end
end
