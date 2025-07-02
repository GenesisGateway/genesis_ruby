# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Consumers::Disable do
  let(:test_required_fields) { %i[email consumer_id] }
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

    configuration
  end
  let(:request) do
    request             = described_class.new configuration
    request.email       = Faker::Internet.email
    request.consumer_id = Faker::Internet.uuid

    request
  end

  describe 'when email' do
    let(:email) { Faker::Internet.email }

    it 'with setter' do
      expect { request.email = email }.to_not raise_error
    end

    it 'with getter' do
      request.email = email

      expect(request.email).to eq email
    end

    it 'with document element' do
      request.email = email

      expect(request.build_document).to include "<email>#{email}</email>"
    end
  end

  describe 'when consumer_id' do
    let(:identifier) { Faker::Internet.uuid }

    it 'with setter' do
      expect { request.consumer_id = identifier }.to_not raise_error
    end

    it 'with getter' do
      request.consumer_id = identifier

      expect(request.consumer_id).to eq identifier
    end

    it 'with document element' do
      request.consumer_id = identifier

      expect(request.build_document).to include "<consumer_id>#{identifier}</consumer_id>"
    end
  end

  include_examples 'base request examples'
  include_examples 'consumer request examples', 'disable_consumer'
  include_examples 'versioned request examples'
end
