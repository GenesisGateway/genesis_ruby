require 'spec/genesis_ruby/stubs/api/requests/financial/business/hotels_and_real_estates_rentals_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::HotelsAndRealEstateRentalsAttributes do
  let(:hotels_and_real_estates_rentals) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::HotelsAndRealEstatesRentalsAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(hotels_and_real_estates_rentals.hotels_and_real_estate_rentals_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        hotels_and_real_estates_rentals.hotels_and_real_estate_rentals_attributes_structure.keys
      ).to eq [
        :check_in_date,
        :check_out_date,
        :travel_agency_name
      ]
    end
  end

  describe 'when business_check_in_date' do
    it 'with valid value' do
      hotels_and_real_estates_rentals.business_check_in_date = fake_date.to_s

      expect(
        hotels_and_real_estates_rentals.business_check_in_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        hotels_and_real_estates_rentals.business_check_in_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_check_out_date' do
    it 'with valid value' do
      hotels_and_real_estates_rentals.business_check_out_date = fake_date.to_s

      expect(
        hotels_and_real_estates_rentals.business_check_out_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        hotels_and_real_estates_rentals.business_check_out_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_travel_agency_name' do
    it 'with accessors' do
      hotels_and_real_estates_rentals.business_travel_agency_name = name = Faker::Company.name

      expect(hotels_and_real_estates_rentals.business_travel_agency_name).to eq name
    end
  end
end
