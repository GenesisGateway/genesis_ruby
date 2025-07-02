# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/business/travel_agencies_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::TravelAgenciesAttributes do
  let(:travel_agencies) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::TravelAgenciesAttributesStub.new
  end
  let(:fake_date) { Faker::Date.in_date_period }

  describe 'with structure' do
    it 'with proper type' do
      expect(travel_agencies.travel_agencies_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        travel_agencies.travel_agencies_attributes_structure.keys
      ).to eq [
        :arrival_date,
        :departure_date,
        :carrier_code,
        :flight_number,
        :ticket_number,
        :origin_city,
        :destination_city,
        :travel_agency,
        :contractor_name,
        :atol_certificate,
        :pick_up_date,
        :return_date
      ]
    end
  end

  describe 'when business_arrival_date' do
    it 'with valid value' do
      travel_agencies.business_arrival_date = fake_date.to_s

      expect(
        travel_agencies.business_arrival_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        travel_agencies.business_arrival_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_departure_date' do
    it 'with valid value' do
      travel_agencies.business_departure_date = fake_date.to_s

      expect(
        travel_agencies.business_departure_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        travel_agencies.business_departure_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_pick_up_date' do
    it 'with valid value' do
      travel_agencies.business_pick_up_date = fake_date.to_s

      expect(
        travel_agencies.business_pick_up_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        travel_agencies.business_pick_up_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_return_date' do
    it 'with valid value' do
      travel_agencies.business_return_date = fake_date.to_s

      expect(
        travel_agencies.business_return_date
      ).to eq fake_date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS)
    end

    it 'with invalid value' do
      expect do
        travel_agencies.business_return_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when business_carrier_code' do
    it 'when accessors' do
      travel_agencies.business_carrier_code = code = Faker::Number.positive

      expect(travel_agencies.business_carrier_code).to eq code
    end
  end

  describe 'when business_flight_number' do
    it 'when accessors' do
      travel_agencies.business_flight_number = code = Faker::Number.positive

      expect(travel_agencies.business_flight_number).to eq code
    end
  end

  describe 'when business_ticket_number' do
    it 'when accessors' do
      travel_agencies.business_ticket_number = code = Faker::Number.positive

      expect(travel_agencies.business_ticket_number).to eq code
    end
  end

  describe 'when business_origin_city' do
    it 'when accessors' do
      travel_agencies.business_origin_city = city = Faker::Address.city

      expect(travel_agencies.business_origin_city).to eq city
    end
  end

  describe 'when business_destination_city' do
    it 'when accessors' do
      travel_agencies.business_destination_city = city = Faker::Address.city

      expect(travel_agencies.business_destination_city).to eq city
    end
  end

  describe 'when business_travel_agency' do
    it 'when accessors' do
      travel_agencies.business_travel_agency = agency = Faker::Company.name

      expect(travel_agencies.business_travel_agency).to eq agency
    end
  end

  describe 'when business_contractor_name' do
    it 'when accessors' do
      travel_agencies.business_contractor_name = name = Faker::Company.name

      expect(travel_agencies.business_contractor_name).to eq name
    end
  end

  describe 'when business_atol_certificate' do
    it 'when accessors' do
      travel_agencies.business_atol_certificate = name = Faker::Internet.uuid

      expect(travel_agencies.business_atol_certificate).to eq name
    end
  end
end
