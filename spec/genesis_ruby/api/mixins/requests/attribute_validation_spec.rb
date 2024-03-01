require 'spec/genesis_ruby/stubs/request_validation'

RSpec.describe GenesisRuby::Api::Mixins::Requests::AttributeValidation do
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) { GenesisSpec::Stubs::RequestValidation.new configuration }

  describe 'when required attributes' do
    it 'without required attribute' do
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with required attribute' do
      request.field1 = Faker::Lorem.word

      expect(request.build_document).to include "<field1>#{request.field1}</field1>"
    end
  end
end
