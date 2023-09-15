require 'spec/genesis_ruby/stubs/api/requests/financial/business/furniture_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::FurnitureAttributes do
  let(:furniture) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::FurnitureAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(furniture.furniture_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        furniture.furniture_attributes_structure.keys
      ).to eq [
        :date_of_order,
        :delivery_date,
        :name_of_the_supplier
      ]
    end
  end

  describe 'when business_date_of_order' do
    it 'with valid value' do
      furniture.business_date_of_order = fake_date.to_s

      expect(
        furniture.business_date_of_order
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        furniture.business_date_of_order = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_delivery_date' do
    it 'with valid value' do
      furniture.business_delivery_date = fake_date.to_s

      expect(
        furniture.business_delivery_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        furniture.business_delivery_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_name_of_the_supplier' do
    it 'with accessors' do
      furniture.business_name_of_the_supplier = name = Faker::Company.name

      expect(furniture.business_name_of_the_supplier).to eq name
    end
  end
end
