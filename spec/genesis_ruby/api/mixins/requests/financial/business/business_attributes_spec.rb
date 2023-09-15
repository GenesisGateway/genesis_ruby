require 'spec/genesis_ruby/stubs/api/requests/financial/business/business_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Business::BusinessAttributes do
  let(:business_attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::Business::BusinessAttributesStub.new
  end

  describe 'with structure' do
    it 'with proper type' do
      expect(business_attributes.business_attributes_structure).to be_kind_of Hash
    end

    it 'with proper structure keys' do # rubocop:disable RSpec/ExampleLength
      expect(
        business_attributes.business_attributes_structure.keys
      ).to eq [
        :payment_type,
        :flight_arrival_date,
        :flight_departure_date,
        :airline_code,
        :airline_flight_number,
        :flight_ticket_number,
        :flight_origin_city,
        :flight_destination_city,
        :airline_tour_operator_name,
        :vehicle_pick_up_date,
        :vehicle_return_date,
        :supplier_name,
        :cruise_start_date,
        :cruise_end_date,
        :event_start_date,
        :event_end_date,
        :event_organizer_id,
        :event_id,
        :date_of_order,
        :delivery_date,
        :name_of_the_supplier,
        :check_in_date,
        :check_out_date,
        :travel_agency_name,
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

  it 'with airlines_air_carrier_attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Business::AirlinesAirCarriersAttributes)
    ).to eq true
  end

  it 'with car_plane_and_boat_rentals_attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Business::CarPlaneAndBoatRentalsAttributes
      )
    ).to eq true
  end

  it 'with cruise_lines_attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Business::CruiseLinesAttributes)
    ).to eq true
  end

  it 'with event_management_attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Business::EventManagementAttributes)
    ).to eq true
  end

  it 'with furniture_attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Business::FurnitureAttributes)
    ).to eq true
  end

  it 'with hotels_and_real_estate_rentals_attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Business::HotelsAndRealEstateRentalsAttributes
      )
    ).to eq true
  end

  it 'with travel_agencies_attributes' do
    expect(
      described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Business::TravelAgenciesAttributes)
    ).to eq true
  end

  describe 'when payment_type' do
    it 'with valid value' do
      business_attributes.business_payment_type = type = GenesisRuby::Api::Constants::Transactions::Parameters::
          Business::PaymentTypes.all.sample

      expect(business_attributes.business_payment_type).to eq type
    end

    it 'with invalid value' do
      expect { business_attributes.business_payment_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
