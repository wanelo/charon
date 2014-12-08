# -*- encoding: utf-8 -*-
# vim: ft=ruby

require File.expand_path('../lib/charon/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["SET ME"]
  gem.email         = ["SET ME"]
  gem.description   = %q{I am an application stub}
  gem.summary       = %q{app stub}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'charon'
  gem.require_paths = %w(lib)
  gem.version       = Charon::VERSION

  # dependencies...
  gem.add_dependency('thor', '0.18.1')
  gem.add_dependency('sysexits', '1.0.2')
  gem.add_dependency('awesome_print', '~> 1.1.0')
  gem.add_dependency('abstract_type', '~> 0.0.7')
  gem.add_dependency('multi_json', '~> 1.10.1')

  # development dependencies.
  gem.add_development_dependency('rspec', '~> 3.0.0')
  gem.add_development_dependency('simplecov', '~> 0.7.0')
  gem.add_development_dependency('guard', '~> 2.1.0')
  gem.add_development_dependency('guard-rspec', '~> 4.2.10')
  gem.add_development_dependency('rubocop', '~> 0.20')
  gem.add_development_dependency('guard-rubocop', '~> 1.1.0')
  gem.add_development_dependency('rainbow', '2.0')
  gem.add_development_dependency('metric_fu', '~> 4.2.0')
  gem.add_development_dependency('guard-reek', '~> 0.0.4')
  gem.add_development_dependency('rake', '~> 10.0.1')
  gem.add_development_dependency('yard', '~> 0.8.7')
  gem.add_development_dependency('redcarpet', '~> 2.3.0')
end
