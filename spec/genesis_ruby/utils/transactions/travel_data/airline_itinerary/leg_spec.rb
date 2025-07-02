# frozen_string_literal: true

require 'genesis_ruby/utils/transactions/travel_data/airline_itinerary/leg'

RSpec.describe GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Leg do
  let(:leg) { described_class.new }
  let(:date) { Faker::Date.forward.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS }

  describe 'when attributes structure' do
    it 'with hash type' do
      expect(leg.attributes_structure).to be_kind_of Hash
    end

    it 'with initialized attributes' do # rubocop:disable RSpec/ExampleLength
      leg = described_class.new departure_date:         date,
                                arrival_date:           date,
                                carrier_code:           12,
                                service_class:          1,
                                origin_city:            'VAR',
                                destination_city:       'FRA',
                                stopover_code:          0,
                                fare_basis_code:        1,
                                flight_number:          'W1234',
                                departure_time:         '11:37',
                                departure_time_segment: 'P'

      expect(leg.attributes_structure).to be_kind_of Hash
    end
  end

  describe 'when departure date' do
    it 'with setter' do
      expect { leg.departure_date = date }.to_not raise_error
    end

    it 'with getter' do
      leg.departure_date = date

      expect(leg.departure_date).to eq date
    end
  end

  describe 'when arrival date' do
    it 'with setter' do
      expect { leg.arrival_date = date }.to_not raise_error
    end

    it 'with getter' do
      leg.arrival_date = date

      expect(leg.arrival_date).to eq date
    end
  end

  describe 'when carrier code' do
    it 'with valid data' do
      expect { leg.carrier_code = 12 }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.carrier_code = 123 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.carrier_code = 12

      expect(leg.carrier_code).to eq 12.to_s
    end

    it 'with nil' do
      leg.carrier_code = nil

      expect(leg.carrier_code).to eq ''
    end
  end

  describe 'when service class' do
    it 'with valid data' do
      expect { leg.service_class = 1 }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.service_class = 12 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.service_class = 1

      expect(leg.service_class).to eq 1.to_s
    end

    it 'with nil' do
      leg.service_class = nil

      expect(leg.service_class).to eq ''
    end
  end

  describe 'when origin city' do
    it 'with valid data' do
      expect { leg.origin_city = 'AAA' }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.origin_city = 'AAAA' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.origin_city = 'AAA'

      expect(leg.origin_city).to eq 'AAA'
    end

    it 'with nil' do
      leg.origin_city = nil

      expect(leg.origin_city).to eq ''
    end
  end

  describe 'when destination city' do
    it 'with valid data' do
      expect { leg.destination_city = 'AAA' }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.destination_city = 'AAAA' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.destination_city = 'AAA'

      expect(leg.destination_city).to eq 'AAA'
    end

    it 'with nil' do
      leg.destination_city = nil

      expect(leg.destination_city).to eq ''
    end
  end

  describe 'when fare basis code' do
    it 'with valid data' do
      expect { leg.fare_basis_code = 123_456 }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.fare_basis_code = 1_234_567 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.fare_basis_code = 123_456

      expect(leg.fare_basis_code).to eq '123456'
    end

    it 'with nil' do
      leg.fare_basis_code = nil

      expect(leg.fare_basis_code).to eq ''
    end
  end

  describe 'when flight number' do
    it 'with valid data' do
      expect { leg.flight_number = 'W1234' }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.flight_number = 'W12345' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.fare_basis_code = 'W1234'

      expect(leg.fare_basis_code).to eq 'W1234'
    end

    it 'with nil' do
      leg.fare_basis_code = nil

      expect(leg.fare_basis_code).to eq ''
    end
  end

  describe 'when departure time segment' do
    it 'with valid data' do
      expect { leg.departure_time_segment = 'P' }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.departure_time_segment = 'I' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.departure_time_segment = 'A'

      expect(leg.departure_time_segment).to eq 'A'
    end
  end

  describe 'when stopover code' do
    it 'with valid data' do
      expect { leg.stopover_code = 1 }.to_not raise_error
    end

    it 'with invalid data' do
      expect { leg.stopover_code = 2 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      leg.stopover_code = nil

      expect(leg.stopover_code).to be nil
    end
  end
end
