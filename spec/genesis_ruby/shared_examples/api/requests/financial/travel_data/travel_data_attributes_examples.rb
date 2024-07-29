RSpec.shared_examples 'travel data attributes examples' do
  describe 'when travel data' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:date) { Faker::Date.forward.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS }
    let(:number) { Faker::Internet.uuid[1..15] }
    let(:name) { Faker::Name.name[1..29] }
    let(:customer_code) { Faker::Internet.uuid[1..17] }
    let(:amount) { Faker::Number.decimal l_digits: 2, r_digits: 2 }
    let(:carrier) { 'AAAA' }
    let(:agency) { Faker::Name.name_with_middle[1..30] }
    let(:agency_code) { Faker::Internet.uuid[1..8] }
    let(:description) { Faker::Lorem.sentence }

    it 'without attributes' do
      expect(request.build_document).to_not include '<travel>'
    end

    describe 'when airline itinerary attributes' do # rubocop:disable RSpec/MultipleMemoizedHelpers
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
      let(:tax) do
        GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Tax.new fee_amount: 0.99, fee_type: 'type'
      end
      let(:init_attributes) do
        # Airline Itinerary Data
        10.times do
          request.add_travel_aid_tax tax
          request.add_travel_aid_leg leg
        end

        request.travel_aid_restricted_ticket_indicator = 1
        request.travel_aid_date_of_issue               = date
        request.travel_aid_ticket_number               = number
        request.travel_aid_passenger_name              = name
        request.travel_aid_customer_code               = customer_code
        request.travel_aid_issuing_carrier             = carrier
        request.travel_aid_total_fare                  = amount
        request.travel_aid_agency_name                 = agency
        request.travel_aid_agency_code                 = agency_code
        request.travel_aid_confirmation_information    = description
      end

      before do
        init_attributes
      end

      it 'with ticket number' do
        expect(request.build_document).to include "<ticket_number>#{number}</ticket_number>"
      end

      it 'with restricted ticket indicator' do
        expect(request.build_document).to include '<restricted_ticket_indicator>1</restricted_ticket_indicator>'
      end

      it 'with date of issue' do
        expect(request.build_document).to include "<date_of_issue>#{date}</date_of_issue>"
      end

      it 'with passenger name' do
        expect(request.build_document).to include "<passenger_name>#{name}</passenger_name>"
      end

      it 'with customer code' do
        expect(request.build_document).to include "<customer_code>#{customer_code}</customer_code>"
      end

      it 'with issuing carrier' do
        expect(request.build_document).to include "<issuing_carrier>#{carrier}</issuing_carrier>"
      end

      it 'with total fare' do
        minor_amount = GenesisRuby::Utils::MoneyFormat.amount_to_exponent amount, request.currency

        expect(request.build_document).to include "<total_fare>#{minor_amount}</total_fare>"
      end

      it 'with agency name' do
        expect(request.build_document).to include "<agency_name>#{agency}</agency_name>"
      end

      it 'with agency code' do
        expect(request.build_document).to include "<agency_code>#{agency_code}</agency_code>"
      end

      it 'with confirmation information' do
        expect(request.build_document).to include "<confirmation_information>#{description}</confirmation_information>"
      end

      it 'with legs' do # rubocop:disable RSpec/ExampleLength
        expect(request.build_document).to include "    <legs>\n" \
                                                  "      <leg>\n" \
                                                  "        <departure_date>#{date}</departure_date>\n" \
                                                  "        <arrival_date>#{date}</arrival_date>\n" \
                                                  "        <carrier_code>12</carrier_code>\n" \
                                                  "        <service_class>1</service_class>\n" \
                                                  "        <origin_city>VAR</origin_city>\n" \
                                                  "        <destination_city>FRA</destination_city>\n" \
                                                  "        <stopover_code>0</stopover_code>\n" \
                                                  "        <fare_basis_code>1</fare_basis_code>\n" \
                                                  "        <flight_number>W1234</flight_number>\n" \
                                                  "        <departure_time>11:37</departure_time>\n" \
                                                  "        <departure_time_segment>P</departure_time_segment>\n" \
                                                  "      </leg>\n"
      end

      it 'with taxes' do
        expect(request.build_document).to include "    <taxes>\n" \
                                                  "      <tax>\n" \
                                                  "        <fee_amount>99</fee_amount>\n" \
                                                  "        <fee_type>type</fee_type>\n" \
                                                  "      </tax>\n"
      end
    end

    describe 'when car rental attributes' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:purchase_id) { Faker::Internet.uuid[1..9] }
      let(:class_id) { [*1..30].push(9999).sample }
      let(:renter_name) { Faker::Lorem.sentence[1..20] }
      let(:return_city) { Faker::Address.city[1..18] }
      let(:return_state) { Faker::Address.state_abbr }
      let(:country_code) { Faker::Address.country_code }
      let(:location_id) { Faker::Lorem.sentence[1..10] }
      let(:extra_charges) { [*1..5].sample }
      let(:no_show_indicator) { [0, 1].sample }
      let(:init_attributes) do
        # Car Rental Data
        request.travel_car_rental_purchase_identifier       = purchase_id
        request.travel_car_rental_class_id                  = class_id
        request.travel_car_rental_pickup_date               = date
        request.travel_car_rental_renter_name               = renter_name
        request.travel_car_rental_return_city               = return_city
        request.travel_car_rental_return_state              = return_state
        request.travel_car_rental_return_country            = country_code
        request.travel_car_rental_return_date               = date
        request.travel_car_rental_renter_return_location_id = location_id
        request.travel_car_rental_customer_code             = customer_code
        request.travel_car_rental_extra_charges             = extra_charges
        request.travel_car_rental_no_show_indicator         = no_show_indicator
      end

      before do
        init_attributes
      end

      it 'with purchase identifier' do
        expect(request.build_document).to include "<purchase_identifier>#{purchase_id}</purchase_identifier>"
      end

      it 'with class id' do
        expect(request.build_document).to include "<class_id>#{class_id}</class_id>"
      end

      it 'with pickup date' do
        expect(request.build_document).to include "<pickup_date>#{date}</pickup_date>"
      end

      it 'with renter name' do
        expect(request.build_document).to include "<renter_name>#{renter_name}</renter_name>"
      end

      it 'with return city' do
        expect(request.build_document).to include "<return_city>#{return_city}</return_city>"
      end

      it 'with return state' do
        expect(request.build_document).to include "<return_state>#{return_state}</return_state>"
      end

      it 'with return country' do
        expect(request.build_document).to include "<return_country>#{country_code}</return_country>"
      end

      it 'with return date' do
        expect(request.build_document).to include "<return_date>#{date}</return_date>"
      end

      it 'with renter return location id' do
        expect(request.build_document)
          .to include "<renter_return_location_id>#{location_id}</renter_return_location_id>"
      end

      it 'with car rental customer code' do
        expect(request.build_document).to include "<customer_code>#{customer_code}</customer_code>"
      end

      it 'with extra charges' do
        expect(request.build_document).to include "<extra_charges>#{extra_charges}</extra_charges>"
      end

      it 'with no show indicator' do
        expect(request.build_document).to include "<no_show_indicator>#{no_show_indicator}</no_show_indicator>"
      end
    end

    describe 'when hotel rental attributes' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:purchase_id) { Faker::Internet.uuid[1..10] }
      let(:no_show_indicator) { [0, 1].sample }
      let(:init_attributes) do
        # Hotel Rental attributes
        request.travel_hotel_rental_purchase_identifier = purchase_id
        request.travel_hotel_rental_arrival_date        = date
        request.travel_hotel_rental_departure_date      = date
        request.travel_hotel_rental_customer_code       = customer_code
        request.travel_hotel_rental_no_show_indicator   = no_show_indicator
      end

      before do
        init_attributes
      end

      it 'with purchase_identifier' do
        expect(request.build_document).to include "<purchase_identifier>#{purchase_id}</purchase_identifier>"
      end

      it 'with arrival date' do
        expect(request.build_document).to include "<arrival_date>#{date}</arrival_date>"
      end

      it 'with departure date' do
        expect(request.build_document).to include "<departure_date>#{date}</departure_date>"
      end

      it 'with customer code' do
        expect(request.build_document).to include "<customer_code>#{customer_code}</customer_code>"
      end

      it 'with no show indicator' do
        expect(request.build_document).to include "<no_show_indicator>#{no_show_indicator}</no_show_indicator>"
      end
    end

    describe 'when reference ticket attributes' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:identifier) { Faker::Internet.uuid[1..32] }
      let(:type) { GenesisRuby::Api::Constants::Transactions::Parameters::TravelData::AncillaryChargesTypes.all.sample }
      let(:number) { Faker::Internet.uuid[1..15] }
      let(:init_attributes) do
        request.travel_ac_ticket_reference_id       = identifier
        request.travel_ac_type                      = type
        request.travel_ac_sub_type                  = type
        request.travel_ac_ticket_document_number    = number
        request.travel_ac_issued_with_ticket_number = number
      end

      before do
        init_attributes
      end

      it 'with ticket reference id' do
        expect(request.build_document).to include "<ticket_reference_id>#{identifier}</ticket_reference_id>"
      end

      it 'with type' do
        expect(request.build_document).to include "<type>#{type}</type>"
      end

      it 'with sub type' do
        expect(request.build_document).to include "<sub_type>#{type}</sub_type>"
      end

      it 'with ticket document number' do
        expect(request.build_document).to include "<ticket_document_number>#{number}</ticket_document_number>"
      end

      it 'with issued with ticket number' do
        expect(request.build_document).to include "<issued_with_ticket_number>#{number}</issued_with_ticket_number>"
      end
    end
  end
end
