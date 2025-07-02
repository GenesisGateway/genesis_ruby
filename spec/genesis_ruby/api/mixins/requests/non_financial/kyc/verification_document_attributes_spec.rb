# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/verification_document_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::VerificationDocumentAttributes do
  let(:attributes)  { GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::VerificationDocumentAttributesStub.new }
  let(:date) do
    Faker::Date.between(from: '1950-01-01', to: '2000-12-31')
               .strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
  end

  it 'when verification document attributes structure' do
    expect(attributes.verification_document_attributes_structure).to be_kind_of Hash
  end

  describe 'when first_name' do
    it 'with setter' do
      expect { attributes.document_first_name = Faker::Name.first_name }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_first_name = value = Faker::Name.first_name

      expect(attributes.document_first_name).to eq value
    end
  end

  describe 'when last_name' do
    it 'with setter' do
      expect { attributes.document_last_name = Faker::Name.last_name }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_last_name = value = Faker::Name.last_name

      expect(attributes.document_last_name).to eq value
    end
  end

  describe 'when date_of_birth' do
    it 'with setter' do
      expect { attributes.document_date_of_birth = date }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_date_of_birth = date

      expect(attributes.document_date_of_birth).to eq date
    end

    it 'with invalid value' do
      expect { attributes.document_date_of_birth = 5 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_offline' do
    it 'with setter' do
      expect { attributes.document_allow_offline = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_allow_offline = true

      expect(attributes.document_allow_offline).to eq true
    end

    it 'with invalid value' do
      expect { attributes.document_allow_offline = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when allow_online' do
    it 'with setter' do
      expect { attributes.document_allow_online = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.document_allow_online = true

      expect(attributes.document_allow_online).to eq true
    end

    it 'with invalid value' do
      expect { attributes.document_allow_online = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

end
