require 'spec/genesis_ruby/stubs/api/requests/financial/customer_identification_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::CustomerIdentificationAttributes do
  let(:customer_identification_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::CustomerIdentificationAttributesStub.new
  end

  describe 'when customer_identification_document_id' do
    let(:value) { Faker::Lorem.characters(number: 20) }

    it 'with setter' do
      expect do
        customer_identification_attributes.customer_identification_document_id = value
      end.to_not raise_error
    end

    it 'with getter' do
      customer_identification_attributes.customer_identification_document_id = value
      expect(customer_identification_attributes.customer_identification_document_id).to eq(value)
    end
  end

  describe 'when customer_identification_owner' do
    let(:valid_owner) do
      GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationOwner.all.sample # rubocop:disable Layout/LineLength
    end

    it 'with setter' do
      expect do
        customer_identification_attributes.customer_identification_owner = valid_owner
      end.to_not raise_error
    end

    it 'with getter' do
      customer_identification_attributes.customer_identification_owner = valid_owner
      expect(customer_identification_attributes.customer_identification_owner).to eq(valid_owner)
    end
  end

  describe 'when customer_identification_type' do
    let(:valid_type) do
      GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationType.all.sample # rubocop:disable Layout/LineLength
    end

    it 'with setter' do
      expect do
        customer_identification_attributes.customer_identification_type = valid_type
      end.to_not raise_error
    end

    it 'with getter' do
      customer_identification_attributes.customer_identification_type = valid_type
      expect(customer_identification_attributes.customer_identification_type).to eq(valid_type)
    end
  end

  describe 'when customer_identification_subtype' do
    let(:valid_subtype) do
      GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationSubtype.all.sample # rubocop:disable Layout/LineLength
    end

    it 'with setter' do
      expect do
        customer_identification_attributes.customer_identification_subtype = valid_subtype
      end.to_not raise_error
    end

    it 'with getter' do
      customer_identification_attributes.customer_identification_subtype = valid_subtype
      expect(customer_identification_attributes.customer_identification_subtype).to eq(valid_subtype)
    end
  end

  describe 'when customer_identification_issuing_country' do
    let(:valid_country) do
      GenesisRuby::Utils::Country::COUNTRIES.keys.sample
    end

    it 'with setter' do
      expect do
        customer_identification_attributes.customer_identification_issuing_country = valid_country
      end.to_not raise_error
    end

    it 'with getter' do
      customer_identification_attributes.customer_identification_issuing_country = valid_country
      expect(customer_identification_attributes.customer_identification_issuing_country).to eq(valid_country)
    end
  end
end
