# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.shared_examples 'dynamic descriptor examples' do
  describe 'when dynamic descriptor' do
    let(:name) { Faker::Name.first_name[0, 25] }
    let(:city) { Faker::Address.city[0, 13] }
    let(:merchant_id) { '0123456789' }
    let(:country) { Faker::Address.country_code }
    let(:state) { Faker::Address.state_abbr }
    let(:zip_code) { Faker::Address.zip_code }
    let(:address) { Faker::Address.street_address }
    let(:url) { Faker::Internet.url }
    let(:phone) { Faker::PhoneNumber.cell_phone }
    let(:coordinates) { "#{Faker::Address.longitude.to_s[..7]}, #{Faker::Address.latitude.to_s[..7]}" }

    it 'has proper structure with dynamic descriptor' do # rubocop:disable RSpec/ExampleLength
      request.dynamic_descriptor_merchant_name                    = name
      request.dynamic_descriptor_merchant_city                    = city
      request.dynamic_descriptor_sub_merchant_id                  = merchant_id
      request.dynamic_descriptor_merchant_country                 = country
      request.dynamic_descriptor_merchant_state                   = state
      request.dynamic_descriptor_merchant_zip_code                = zip_code
      request.dynamic_descriptor_merchant_address                 = address
      request.dynamic_descriptor_merchant_url                     = url
      request.dynamic_descriptor_merchant_phone                   = phone
      request.dynamic_descriptor_merchant_service_city            = city
      request.dynamic_descriptor_merchant_geo_coordinates         = coordinates
      request.dynamic_descriptor_merchant_service_country         = country
      request.dynamic_descriptor_merchant_service_state           = state
      request.dynamic_descriptor_merchant_service_zip_code        = zip_code
      request.dynamic_descriptor_merchant_service_phone           = phone
      request.dynamic_descriptor_merchant_service_geo_coordinates = coordinates

      expect(request.build_document).to include '<dynamic_descriptor_params>'
    end

    it 'has proper structure without dynamic descriptor' do
      expect(request.build_document).to_not include 'dynamic_descriptor_params'
    end

    it 'has proper structure with dynamic descriptor merchant name' do
      request.dynamic_descriptor_merchant_name = name

      expect(request.build_document).to include "<merchant_name>#{name}</merchant_name>"
    end

    it 'has proper structure with dynamic descriptor merchant city' do
      request.dynamic_descriptor_merchant_city = city

      expect(request.build_document).to include "<merchant_city>#{city}</merchant_city>"
    end

    it 'has proper structure with dynamic descriptor sub merchant id' do
      request.dynamic_descriptor_sub_merchant_id = merchant_id

      expect(request.build_document).to include "<sub_merchant_id>#{merchant_id}</sub_merchant_id>"
    end

    it 'has proper structure with dynamic descriptor merchant country' do
      request.dynamic_descriptor_merchant_country = country

      expect(request.build_document).to include "<merchant_country>#{country}</merchant_country>"
    end

    it 'has proper structure with dynamic descriptor merchant state' do
      request.dynamic_descriptor_merchant_state = state

      expect(request.build_document).to include "<merchant_state>#{state}</merchant_state>"
    end

    it 'has proper structure with dynamic descriptor merchant zip code' do
      request.dynamic_descriptor_merchant_zip_code = zip_code

      expect(request.build_document).to include "<merchant_zip_code>#{zip_code}</merchant_zip_code>"
    end

    it 'has proper structure with dynamic descriptor merchant address' do
      request.dynamic_descriptor_merchant_address = address

      expect(request.build_document).to include "<merchant_address>#{address}</merchant_address>"
    end

    it 'has proper structure with dynamic descriptor merchant url' do
      request.dynamic_descriptor_merchant_url = url

      expect(request.build_document).to include "<merchant_url>#{url}</merchant_url>"
    end

    it 'has proper structure with dynamic descriptor merchant phone' do
      request.dynamic_descriptor_merchant_phone = phone

      expect(request.build_document).to include "<merchant_phone>#{phone}</merchant_phone>"
    end

    it 'with proper structure with dynamic descriptor merchant geo coordinates' do
      request.dynamic_descriptor_merchant_geo_coordinates = coordinates

      expect(request.build_document).to include "<merchant_geo_coordinates>#{coordinates}</merchant_geo_coordinates>"
    end

    it 'has proper structure with dynamic descriptor merchant service city' do
      request.dynamic_descriptor_merchant_service_city = city

      expect(request.build_document).to include "<merchant_service_city>#{city}</merchant_service_city>"
    end

    it 'has proper structure with dynamic descriptor merchant service country' do
      request.dynamic_descriptor_merchant_service_country = country

      expect(request.build_document).to include "<merchant_service_country>#{country}</merchant_service_country>"
    end

    it 'has proper structure with dynamic descriptor merchant service state' do
      request.dynamic_descriptor_merchant_service_state = state

      expect(request.build_document).to include "<merchant_service_state>#{state}</merchant_service_state>"
    end

    it 'has proper structure with dynamic descriptor merchant service zip code' do
      request.dynamic_descriptor_merchant_service_zip_code = zip_code

      expect(request.build_document).to include "<merchant_service_zip_code>#{zip_code}</merchant_service_zip_code>"
    end

    it 'has proper structure with dynamic descriptor merchant service phone' do
      request.dynamic_descriptor_merchant_service_phone = phone

      expect(request.build_document).to include "<merchant_service_phone>#{phone}</merchant_service_phone>"
    end

    it 'with proper structure with dynamic descriptor merchant service geo coordinates' do
      request.dynamic_descriptor_merchant_service_geo_coordinates = coordinates

      expect(request.build_document)
        .to include "<merchant_service_geo_coordinates>#{coordinates}</merchant_service_geo_coordinates>"
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
