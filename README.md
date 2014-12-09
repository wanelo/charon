# Charon

Charon is a daemon that watches a named pipe for files that have been uploaded to an FTP server
by users. It was designed to work with PureFTPd's upload-script feature. PureFTPd will write the
full path to the uploaded file once it has finished uploading to a named pipe in /var/run/pure-ftpd.

Charon listens to that named pipe for those paths, publishes the uploaded files to NFS, Object Storage,
etc. and then notifies people of the file's existence via RabbitMQ.

## Installation

Add this line to your application's Gemfile:

    gem 'charon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install charon

## Usage

    `bundle exec bin/charon start [path/to/coniguration.yml]`

## Configuration

The configuration must contain, at a minimum, the following:

```yaml
listening:
  pipe_path: /var/run/named.pipe
messaging:
  exchange: charon
  routing_key: charon.uploads
  rabbitmq:
    host: 'localhost'
    port: 5672
    user: 'guest'
    password: 'guest'
publishing:
  nfs:
    dest_dir: /mnt/nfs
logging:
  level: debug
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Testing

The Rakefile comes with several convenience tasks for running tests as well. By rake task:

  + `spec`: Runs all rspec tests in the spec directory.
  + `yard`: Generates yard documentation.
  + `reek_lib`: Runs reek on the lib directory only.
  + `rubocop`: Runs rubocop.
  + `run_guards`: Runs all guards.

`run_guards` is the one you're most likely to want to run, since it runs all the other test-related tasks.
