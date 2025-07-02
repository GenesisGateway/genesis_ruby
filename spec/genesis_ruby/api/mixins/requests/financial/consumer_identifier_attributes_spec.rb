# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/consumer_identifier_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::ConsumerIdentifierAttributes do
  let(:consumer_identifier) { GenesisSpec::Stubs::Api::Requests::Financial::ConsumerIdentifierAttributesStub.new }

  describe 'when consumer_reference' do
    it 'with setter' do
      expect { consumer_identifier.consumer_reference = Faker::Internet.uuid[..19] }.to_not raise_error
    end

    it 'with getter' do
      consumer_identifier.consumer_reference = identifier = Faker::Internet.uuid[..19]

      expect(consumer_identifier.consumer_reference).to eq identifier
    end

    it 'with invalid value' do
      expect { consumer_identifier.consumer_reference = Faker::Internet.uuid[..21] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when national_id' do
    it 'with setter' do
      expect { consumer_identifier.national_id = Faker::Internet.uuid[..19] }.to_not raise_error
    end

    it 'with getter' do
      consumer_identifier.national_id = identifier = Faker::Internet.uuid[..19]

      expect(consumer_identifier.national_id).to eq identifier
    end

    it 'with invalid value' do
      expect { consumer_identifier.consumer_reference = Faker::Internet.uuid[..21] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
