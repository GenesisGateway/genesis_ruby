# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/travel_data/airline_itinerary_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::TravelData::AirlineItineraryAttributes do
  let(:aid) { GenesisSpec::Stubs::Api::Requests::Financial::TravelData::AirlineItineraryAttributesStub.new }
  let(:date) { Faker::Date.forward.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS }

  describe 'when legs' do
    let(:leg) do
      GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Leg.new departure_date:         date,
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
    end
    let(:init_legs) { 10.times { aid.add_travel_aid_leg leg } }

    it 'with valid legs count' do
      init_legs

      expect(aid.travel_aid_legs.count).to eq 10
    end

    it 'with invalid legs count' do
      init_legs

      expect { aid.add_travel_aid_leg leg }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with legs structure' do
      aid.add_travel_aid_leg leg

      expect(aid.__send__(:legs_structure)[:leg]).to be_kind_of Array
    end

    it 'with clear legs' do
      init_legs
      aid.clear_travel_aid_legs

      expect(aid.travel_aid_legs.count).to eq 0
    end

    it 'with invalid leg' do
      expect { aid.add_travel_aid_leg 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when taxes' do
    let(:tax) do
      GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Tax.new fee_amount: 0.99, fee_type: 'type'
    end
    let(:init_taxes) { 10.times { aid.add_travel_aid_tax tax } }

    it 'with valid taxes count' do
      init_taxes

      expect(aid.travel_aid_taxes.count).to eq 10
    end

    it 'with invalid taxes count' do
      init_taxes

      expect { aid.add_travel_aid_tax tax }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with taxes structure' do
      aid.add_travel_aid_tax tax

      expect(aid.__send__(:taxes_structure)[:tax]).to be_kind_of Array
    end

    it 'with clear taxes' do
      init_taxes
      aid.clear_travel_aid_taxes

      expect(aid.travel_aid_taxes.count).to eq 0
    end

    it 'with invalid tax' do
      expect { aid.add_travel_aid_tax 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when restricted ticket indicator' do
    it 'with valid data' do
      expect { aid.travel_aid_restricted_ticket_indicator = 1 }.to_not raise_error
    end

    it 'with invalid data' do
      expect { aid.travel_aid_restricted_ticket_indicator = 2 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with nil value' do
      aid.travel_aid_restricted_ticket_indicator = nil

      expect(aid.travel_aid_restricted_ticket_indicator).to eq 0
    end
  end

  describe 'when date of issue' do
    it 'with setter' do
      expect { aid.travel_aid_date_of_issue = date }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_date_of_issue = date

      expect(aid.travel_aid_date_of_issue).to eq date
    end
  end

  describe 'when ticket number' do
    let(:number) { Faker::Internet.uuid[1..15] }

    it 'with setter' do
      expect { aid.travel_aid_ticket_number = number }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_ticket_number = number

      expect(aid.travel_aid_ticket_number).to eq number
    end
  end

  describe 'when passenger name' do
    let(:name) { Faker::Name.name[1..29] }

    it 'with setter' do
      expect { aid.travel_aid_passenger_name = name }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_passenger_name = name

      expect(aid.travel_aid_passenger_name).to eq name
    end
  end

  describe 'when customer code' do
    let(:code) { Faker::Internet.uuid[1..17] }

    it 'with setter' do
      expect { aid.travel_aid_customer_code = code }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_customer_code = code

      expect(aid.travel_aid_customer_code).to eq code
    end
  end

  describe 'when issuing carrier' do
    let(:carrier) { 'AAAA' }

    it 'with setter' do
      expect { aid.travel_aid_issuing_carrier = carrier }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_issuing_carrier = carrier

      expect(aid.travel_aid_issuing_carrier).to eq carrier
    end
  end

  describe 'when total fare' do
    let(:digit) { Faker::Number.decimal l_digits: 2, r_digits: 2 }

    it 'with setter' do
      expect { aid.travel_aid_total_fare = digit }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_total_fare = digit

      expect(aid.travel_aid_total_fare).to eq digit
    end
  end

  describe 'when agency name' do
    let(:agency) { Faker::Name.name_with_middle[1..30] }

    it 'with setter' do
      expect { aid.travel_aid_agency_name = agency }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_agency_name = agency

      expect(aid.travel_aid_agency_name).to eq agency
    end
  end

  describe 'when agency code' do
    let(:code) { Faker::Internet.uuid[1..8] }

    it 'with setter' do
      expect { aid.travel_aid_agency_code = code }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_agency_code = code

      expect(aid.travel_aid_agency_code).to eq code
    end
  end

  describe 'when confirmation information' do
    let(:description) { Faker::Lorem.sentence[1..474] }

    it 'with setter' do
      expect { aid.travel_aid_confirmation_information = description }.to_not raise_error
    end

    it 'with getter' do
      aid.travel_aid_confirmation_information = description

      expect(aid.travel_aid_confirmation_information).to eq description
    end
  end
end
