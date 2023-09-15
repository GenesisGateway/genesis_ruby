require 'spec/genesis_ruby/stubs/api/requests/financial/business/car_plane_and_boat_rentals_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::CarPlaneAndBoatRentalsAttributes do
  let(:car_plane_and_boat) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::CarPlaneAndBoatRentalsAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(car_plane_and_boat.car_plane_and_boat_rentals_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        car_plane_and_boat.car_plane_and_boat_rentals_attributes_structure.keys
      ).to eq [
        :vehicle_pick_up_date,
        :vehicle_return_date,
        :supplier_name
      ]
    end
  end

  describe 'when business_vehicle_pick_up_date' do
    it 'with valid value' do
      car_plane_and_boat.business_vehicle_pick_up_date = fake_date.to_s

      expect(
        car_plane_and_boat.business_vehicle_pick_up_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        car_plane_and_boat.business_vehicle_pick_up_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_vehicle_return_date' do
    it 'with valid value' do
      car_plane_and_boat.business_vehicle_return_date = fake_date.to_s

      expect(
        car_plane_and_boat.business_vehicle_return_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        car_plane_and_boat.business_vehicle_return_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_supplier_name' do
    it 'with accessors' do
      car_plane_and_boat.business_supplier_name = name = Faker::Company.name

      expect(car_plane_and_boat.business_supplier_name).to eq name
    end
  end
end
