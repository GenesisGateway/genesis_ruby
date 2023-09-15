require 'spec/genesis_ruby/stubs/api/requests/financial/business/airlines_air_carriers_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::AirlinesAirCarriersAttributes do
  let(:airlines_air_carriers) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::AirlinesAirCarriersAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(airlines_air_carriers.airlines_air_carriers_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        airlines_air_carriers.airlines_air_carriers_attributes_structure.keys
      ).to eq [
        :flight_arrival_date,
        :flight_departure_date,
        :airline_code,
        :airline_flight_number,
        :flight_ticket_number,
        :flight_origin_city,
        :flight_destination_city,
        :airline_tour_operator_name
      ]
    end
  end

  describe 'when business_flight_arrival_date' do
    it 'with valid value' do
      airlines_air_carriers.business_flight_arrival_date = fake_date.to_s

      expect(
        airlines_air_carriers.business_flight_arrival_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        airlines_air_carriers.business_flight_arrival_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_flight_departure_date' do
    it 'with valid value' do
      airlines_air_carriers.business_flight_departure_date = fake_date.to_s

      expect(
        airlines_air_carriers.business_flight_departure_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        airlines_air_carriers.business_flight_departure_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_airline_code' do
    it 'with accessors' do
      airlines_air_carriers.business_airline_code = code = Faker::Number.positive

      expect(airlines_air_carriers.business_airline_code).to eq code
    end
  end

  describe 'when business_airline_flight_number' do
    it 'with accessors' do
      airlines_air_carriers.business_airline_flight_number = number = Faker::Number.positive

      expect(airlines_air_carriers.business_airline_flight_number).to eq number
    end
  end

  describe 'when business_flight_ticket_number' do
    it 'with accessors' do
      airlines_air_carriers.business_flight_ticket_number = number = Faker::Number.positive

      expect(airlines_air_carriers.business_flight_ticket_number).to eq number
    end
  end

  describe 'when business_flight_origin_city' do
    it 'with accessors' do
      airlines_air_carriers.business_flight_origin_city = city = Faker::Address.city

      expect(airlines_air_carriers.business_flight_origin_city).to eq city
    end
  end

  describe 'when business_flight_destination_city' do
    it 'with accessors' do
      airlines_air_carriers.business_flight_destination_city = city = Faker::Address.city

      expect(airlines_air_carriers.business_flight_destination_city).to eq city
    end
  end

  describe 'when business_airline_tour_operator_name' do
    it 'with accessors' do
      airlines_air_carriers.business_airline_tour_operator_name = name = Faker::Company.name

      expect(airlines_air_carriers.business_airline_tour_operator_name).to eq name
    end
  end
end
