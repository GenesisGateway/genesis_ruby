# frozen_string_literal: true

RSpec.shared_examples 'business attributes examples' do
  let(:business_attributes) do
    ## Airlines Air Carriers
    request.business_flight_arrival_date        = Faker::Date.in_date_period.to_s
    request.business_flight_departure_date      = Faker::Date.in_date_period.to_s
    request.business_airline_code               = Faker::Number.positive
    request.business_airline_flight_number      = Faker::Number.positive
    request.business_flight_ticket_number       = Faker::Number.positive
    request.business_airline_flight_number      = Faker::Number.positive
    request.business_origin_city                = Faker::Address.city
    request.business_destination_city           = Faker::Address.city
    request.business_airline_tour_operator_name = Faker::Company.name

    ## Car, Plane, and Boat Rentals
    request.business_vehicle_pick_up_date = Faker::Date.in_date_period.to_s
    request.business_return_date          = Faker::Date.in_date_period.to_s
    request.business_supplier_name        = Faker::Company.name

    ## Cruise Lines
    request.business_cruise_start_date = Faker::Date.in_date_period.to_s
    request.business_cruise_end_date   = Faker::Date.in_date_period.to_s

    ## Event Management
    request.business_event_start_date   = Faker::Date.in_date_period.to_s
    request.business_event_end_date     = Faker::Date.in_date_period.to_s
    request.business_event_organizer_id = Faker::Number.positive
    request.business_event_id           = Faker::Number.positive

    ## Furniture
    request.business_date_of_order        = Faker::Date.in_date_period.to_s
    request.business_delivery_date        = Faker::Date.in_date_period.to_s
    request.business_name_of_the_supplier = Faker::Company.name

    ## Hotels an Real Estate Rentals
    request.business_check_in_date       = Faker::Date.in_date_period.to_s
    request.business_check_out_date      = Faker::Date.in_date_period.to_s
    request.business_travel_agency_name  = Faker::Company.name

    ## Travel Agencies
    request.business_arrival_date     = Faker::Date.in_date_period.to_s
    request.business_departure_date   = Faker::Date.in_date_period.to_s
    request.business_carrier_code     = Faker::Number.positive
    request.business_flight_number    = Faker::Number.positive
    request.business_ticket_number    = Faker::Number.positive
    request.business_origin_city      = Faker::Number.positive
    request.business_destination_city = Faker::Number.positive
    request.business_travel_agency    = Faker::Company.name
    request.business_contractor_name  = Faker::Company.name
    request.business_atol_certificate = Faker::Internet.uuid
    request.business_pick_up_date     = Faker::Date.in_date_period.to_s
    request.business_return_date      = Faker::Date.in_date_period.to_s

    request
  end

  describe 'when business_attributes' do
    it 'has proper structure without business attributes' do
      expect(request.build_document).to_not include 'business_attributes'
    end

    it 'has proper structure with business attributes' do
      expect(business_attributes.build_document).to include '<business_attributes>'
    end
  end
end
