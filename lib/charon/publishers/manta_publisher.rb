module Charon
# Uploads files to Manta
  class Publisher < ErrorRaisingDeferrable
    attr_reader :client, :upload_path_prefix

    def initialize
      super

      @priv_key = File.read(priv_key_path)
      @client = MantaClient.new(host, user, priv_key, disable_ssl_verification: true)
      @upload_path_prefix = '/product_feeds'
      client.put_directory(@upload_path)
    end

    # #publish -- receives a path to a local file and uploads it to Manta. Paths should
    # be something along the lines of `/var/data/ftp/username/file.txt.zip`
    # The username currently must be part of the path exactly as described.
    #
    # On success, yields the path to the file in Manta to the callback.
    # On failure, raises an exception.
    # @param [String] path Path to local file
    def publish(local_path)
      user, filename = local_path.split('/')[-2..-1]
      upload_path = "manta://#{upload_path_prefix}/#{user}/#{filename}"
      EM.defer do
        begin
          client.put_object(upload_path)
          succeed(user, upload_path)
        rescue => e
          # Fail should raise exceptions to begin with
          fail(e)
        end
      end
    end
  end
end
