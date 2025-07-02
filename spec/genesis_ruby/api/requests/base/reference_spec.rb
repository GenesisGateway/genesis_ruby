# frozen_string_literal: true

require 'genesis_ruby/api/requests/base/reference'
require 'spec/genesis_ruby/stubs/api/requests/base/reference_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Reference do
  let(:token) { Faker::Internet.uuid }
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING
    configuration.token       = token

    configuration
  end

  describe 'without implementation' do
    let(:reference) { described_class.new configuration }

    it 'with error when payment_transaction_structure' do
      expect { reference.__send__(:reference_transaction_structure) }.to raise_error NotImplementedError
    end

    it 'with xml configuration' do
      expect(reference.api_config[:format]).to eq 'xml'
    end

    it 'with api gateway configuration' do
      expect(reference.api_config[:url]).to eq "https://staging.gate.emerchantpay.net:443/process/#{token}/"
    end
  end

  describe 'with implementation' do
    let(:request) do
      request = GenesisSpec::Stubs::Api::Requests::Base::ReferenceStub.new configuration
      request.transaction_id = Faker::Internet.uuid
      request.reference_id   = Faker::Internet.uuid
      request.usage          = Faker::Lorem.sentence
      request.remote_ip      = Faker::Internet.ip_v4_address
      request.currency       = 'EUR'
      request.amount         = '1.99'

      request
    end

    include_examples 'base request examples'
    include_examples 'financial attributes examples'
    include_examples 'financial structure examples'
    include_examples 'payment attributes examples'
    include_examples 'reference attributes examples'
  end
end
