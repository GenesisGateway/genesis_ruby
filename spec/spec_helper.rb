$LOAD_PATH.unshift('./')

require 'webmock/rspec'
require 'spec/genesis_ruby/stubs/fake_request'
require 'genesis_ruby'
require 'faker'

# Load Shared examples
Dir['spec/genesis_ruby/shared_examples/**/*_examples.rb'].sort.each { |file| require file }

RSpec.configure do |config|
  WebMock.disable_net_connect!(allow_localhost: true)

  config.before do
    stub_request(:any, /emerchantpay.net/).to_rack(GenesisSpec::Stubs::FakeRequest)
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
