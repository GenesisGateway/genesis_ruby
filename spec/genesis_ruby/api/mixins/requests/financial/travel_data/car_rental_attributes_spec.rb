# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/travel_data/car_rental_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::TravelData::CarRentalAttributes do
  let(:car_rental) { GenesisSpec::Stubs::Api::Requests::Financial::TravelData::CarRentalAttributesStub.new }

  describe 'when car rental structure' do
    it 'with hash type attributes structure' do
      expect(car_rental.__send__(:car_rental_attributes_structure)).to be_kind_of Hash
    end

    it 'with attributes node' do
      expect(car_rental.__send__(:car_rental_attributes_structure)).to have_key :car_rental
    end

    it 'with hash type inside attribute node' do
      expect(car_rental.__send__(:car_rental_attributes_structure)[:car_rental]).to be_kind_of Hash
    end
  end

  describe 'when travel purchase indicator' do
    let(:identifier) { Faker::Internet.uuid[1..9] }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_purchase_identifier = identifier }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_purchase_identifier = Faker::Internet.uuid }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_purchase_identifier = identifier

      expect(car_rental.travel_car_rental_purchase_identifier).to eq identifier
    end
  end

  describe 'when travel class id' do
    let(:identifier) { [*1..30].push(9999).sample }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_class_id = identifier }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_class_id = 0 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_class_id = identifier.to_s

      expect(car_rental.travel_car_rental_class_id).to be identifier
    end
  end

  describe 'when travel pickup date' do
    let(:date) { Faker::Date.forward.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS) }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_pickup_date = date }.to_not raise_error
    end

    it 'with getter' do
      car_rental.travel_car_rental_pickup_date = date

      expect(car_rental.travel_car_rental_pickup_date).to eq date
    end
  end

  describe 'when renter name' do
    let(:name) { Faker::String.random length: 20 }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_renter_name = name }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_renter_name = "#{name}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_renter_name = name

      expect(car_rental.travel_car_rental_renter_name).to eq name
    end
  end

  describe 'when return city' do
    let(:city) { Faker::Address.city[1..18] }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_return_city = city }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_return_city = Faker::String.random(length: 19) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_return_city = city

      expect(car_rental.travel_car_rental_return_city).to eq city
    end
  end

  describe 'when return state' do
    let(:state) { Faker::Address.state_abbr }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_return_state = state }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_return_state = "#{state}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_return_state = state

      expect(car_rental.travel_car_rental_return_state).to eq state
    end
  end

  describe 'when return country' do
    let(:country) { Faker::Address.country_code }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_return_country = country }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_return_country = "#{country}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_return_country = country

      expect(car_rental.travel_car_rental_return_country).to eq country
    end
  end

  describe 'when travel return date' do
    let(:date) { Faker::Date.forward.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS) }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_return_date = date }.to_not raise_error
    end

    it 'with getter' do
      car_rental.travel_car_rental_return_date = date

      expect(car_rental.travel_car_rental_return_date).to eq date
    end
  end

  describe 'when renter return location id' do
    let(:identifier) { Faker::String.random(length: 10) }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_renter_return_location_id = identifier }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_renter_return_location_id = "#{identifier}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_renter_return_location_id = identifier

      expect(car_rental.travel_car_rental_renter_return_location_id).to eq identifier
    end
  end

  describe 'when travel car rental customer code' do
    let(:code) { Faker::String.random(length: 17) }

    it 'with valid data' do
      expect { car_rental.travel_car_rental_customer_code = code }.to_not raise_error
    end

    it 'with invalid data' do
      expect { car_rental.travel_car_rental_customer_code = "#{code}invalid" }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_customer_code = code

      expect(car_rental.travel_car_rental_customer_code).to eq code
    end
  end

  describe 'when travel extra charges' do
    let(:charge) { [*1..5].sample }

    it 'with valid value' do
      expect { car_rental.travel_car_rental_extra_charges = charge }.to_not raise_error
    end

    it 'with invalid value' do
      expect { car_rental.travel_car_rental_extra_charges = 6 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_extra_charges = charge

      expect(car_rental.travel_car_rental_extra_charges).to eq charge
    end
  end

  describe 'when travel no show indicator' do
    let(:indicator) { [0, 1].sample }

    it 'with valid value' do
      expect { car_rental.travel_car_rental_no_show_indicator = indicator }.to_not raise_error
    end

    it 'with invalid value' do
      expect { car_rental.travel_car_rental_no_show_indicator = 2 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      car_rental.travel_car_rental_no_show_indicator = indicator

      expect(car_rental.travel_car_rental_no_show_indicator).to eq indicator
    end
  end
end
