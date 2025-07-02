# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/verification_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::VerificationAttributes do
  let(:attributes)  { GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::VerificationAttributesStub.new }
  let(:expiry_date) do
    Faker::Date.forward.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
  end
  let(:supported_types) do
    GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentSupportedTypes.all.sample(2)
  end
  let(:country) do
    GenesisRuby::Utils::Country::COUNTRIES.keys.sample
  end

  describe 'when reference_id' do
    it 'with setter' do
      expect { attributes.reference_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      attributes.reference_id = value = Faker::Internet.uuid

      expect(attributes.reference_id).to eq value
    end
  end

  describe 'when email' do
    it 'with setter' do
      expect { attributes.email = Faker::Internet.email }.to_not raise_error
    end

    it 'with getter' do
      attributes.email = value = Faker::Internet.email

      expect(attributes.email).to eq value
    end

    it 'with invalid value' do
      expect { attributes.email = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when expiry_date' do
    it 'with setter' do
      expect { attributes.expiry_date = expiry_date }.to_not raise_error
    end

    it 'with getter' do
      attributes.expiry_date = expiry_date

      expect(attributes.expiry_date).to eq expiry_date
    end

    it 'with invalid value' do
      expect { attributes.expiry_date = 5 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when document_supported_types' do
    it 'with setter' do
      expect { attributes.document_supported_types = supported_types }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_supported_types = supported_types

      expect(attributes.document_supported_types).to eq supported_types
    end

    it 'with invalid value' do
      expect { attributes.document_supported_types = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with empty value' do
      expect { attributes.document_supported_types = [] }.to_not raise_error
    end
  end

  describe 'when backside_proof_required' do
    it 'with setter' do
      expect { attributes.backside_proof_required = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.backside_proof_required = true

      expect(attributes.backside_proof_required).to eq true
    end

    it 'with invalid value' do
      expect { attributes.backside_proof_required = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when country' do
    it 'with setter' do
      expect { attributes.country = country }.to_not raise_error
    end

    it 'with getter' do
      attributes.country = country

      expect(attributes.country).to eq country
    end

    it 'with invalid value' do
      expect { attributes.country = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

end
