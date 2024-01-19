lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'genesis_ruby/version'

Gem::Specification.new do |spec|
  spec.name                        = 'genesis_ruby'
  spec.version                     = GenesisRuby::VERSION
  spec.authors                     = ['emerchantpay Ltd.']
  spec.email                       = ['client_integrations@emerchantpay.com']

  spec.summary                     = 'Ruby Client for Genesis Payment Processing Gateway'
  spec.homepage                    = 'https://github.com/GenesisGateway/genesis_ruby'
  spec.license                     = 'MIT'
  spec.required_ruby_version       = '>= 2.7.0'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/GenesisGateway/genesis_ruby'
  spec.metadata['changelog_uri']     = 'https://github.com/GenesisGateway/genesis_ruby/blob/main/CHANGELOG.md'
  spec.metadata['documentation_uri'] = 'https://github.com/GenesisGateway/genesis_ruby/blob/main/README.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(bin|test|spec|features|sig)/|\.(?:git|pronto|rspec|rubocop)})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'net-http', '~> 0.3.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.14'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'faker', '~> 2.22'
  spec.add_development_dependency 'faraday-retry', '~> 2.0'
  spec.add_development_dependency 'pronto', '~> 0.11'
  spec.add_development_dependency 'pronto-rubocop', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.6'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency 'rubocop-faker', '~> 1.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.13'
  spec.add_development_dependency 'sinatra', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.18'
end
