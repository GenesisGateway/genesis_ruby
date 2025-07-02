# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/travel_data/hotel_rental_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::TravelData::HotelRentalAttributes do
  let(:hotel_rental) { GenesisSpec::Stubs::Api::Requests::Financial::TravelData::HotelRentalAttributesStub.new }

  describe 'when purchase identifier' do
    let(:identifier) { Faker::Internet.uuid[1..10] }

    it 'with valid data' do
      expect { hotel_rental.travel_hotel_rental_purchase_identifier = identifier }.to_not raise_error
    end

    it 'with invalid data' do
      expect { hotel_rental.travel_hotel_rental_purchase_identifier = "#{identifier}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      hotel_rental.travel_hotel_rental_purchase_identifier = identifier

      expect(hotel_rental.travel_hotel_rental_purchase_identifier).to eq identifier
    end
  end

  describe 'when arrival date' do
    let(:date) { Faker::Date.forward.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS) }

    it 'with valid data' do
      expect { hotel_rental.travel_hotel_rental_arrival_date = date }.to_not raise_error
    end

    it 'with getter' do
      hotel_rental.travel_hotel_rental_arrival_date = date

      expect(hotel_rental.travel_hotel_rental_arrival_date).to eq date
    end
  end

  describe 'when departure date' do
    let(:date) { Faker::Date.forward.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS) }

    it 'with valid data' do
      expect { hotel_rental.travel_hotel_rental_departure_date = date }.to_not raise_error
    end

    it 'with getter' do
      hotel_rental.travel_hotel_rental_departure_date = date

      expect(hotel_rental.travel_hotel_rental_departure_date).to eq date
    end
  end

  describe 'when customer code' do
    let(:code) { Faker::Internet.uuid[1..17] }

    it 'with valid data' do
      expect { hotel_rental.travel_hotel_rental_customer_code = code }.to_not raise_error
    end

    it 'with invalid data' do
      expect { hotel_rental.travel_hotel_rental_customer_code = "#{code}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      hotel_rental.travel_hotel_rental_customer_code = code

      expect(hotel_rental.travel_hotel_rental_customer_code).to eq code
    end
  end

  describe 'when extra charges' do
    let(:charge) { [*2..7].sample }

    it 'with valid data' do
      expect { hotel_rental.travel_hotel_rental_extra_charges = charge }.to_not raise_error
    end

    it 'with invalid data' do
      expect { hotel_rental.travel_hotel_rental_extra_charges = 8 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      hotel_rental.travel_hotel_rental_extra_charges = charge

      expect(hotel_rental.travel_hotel_rental_extra_charges).to eq charge
    end
  end

  describe 'when no show indicator' do
    let(:indicator) { [0, 1].sample }

    it 'with valid data' do
      expect { hotel_rental.travel_hotel_rental_no_show_indicator = indicator }.to_not raise_error
    end

    it 'with invalid data' do
      expect { hotel_rental.travel_hotel_rental_no_show_indicator = 2 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      hotel_rental.travel_hotel_rental_no_show_indicator = indicator

      expect(hotel_rental.travel_hotel_rental_no_show_indicator).to eq indicator
    end
  end
end
