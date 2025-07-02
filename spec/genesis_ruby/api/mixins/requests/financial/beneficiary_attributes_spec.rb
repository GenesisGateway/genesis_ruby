# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/beneficiary_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::BeneficiaryAttributes do
  let(:beneficiary) { GenesisSpec::Stubs::Api::Requests::Financial::BeneficiaryAttributesStub.new }

  describe 'when beneficiary_name' do
    it 'with setter' do
      expect { beneficiary.beneficiary_name = Faker::Name.name }.to_not raise_error
    end

    it 'with getter' do
      beneficiary.beneficiary_name = name = Faker::Name.name

      expect(beneficiary.beneficiary_name).to eq name
    end
  end

  describe 'when beneficiary_document_id' do
    it 'with setter' do
      expect { beneficiary.beneficiary_document_id = Faker::Internet.uuid[..13] }.to_not raise_error
    end

    it 'with getter' do
      beneficiary.beneficiary_document_id = identifier = Faker::Internet.uuid[..13]

      expect(beneficiary.beneficiary_document_id).to eq identifier
    end

    it 'with invalid value' do
      expect { beneficiary.beneficiary_document_id = Faker::Internet.uuid[..15] }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when beneficiary_pix_key' do
    it 'with setter' do
      expect { beneficiary.beneficiary_pix_key = Faker::Lorem.characters(number: 36) }.to_not raise_error
    end

    it 'with getter' do
      beneficiary.beneficiary_pix_key = key = Faker::Lorem.characters(number: 36)

      expect(beneficiary.beneficiary_pix_key).to eq key
    end

    it 'with invalid value' do
      expect { beneficiary.beneficiary_pix_key = Faker::Lorem.characters(number: 37) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
