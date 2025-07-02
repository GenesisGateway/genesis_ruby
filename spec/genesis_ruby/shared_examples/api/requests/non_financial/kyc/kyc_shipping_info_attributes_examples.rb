# frozen_string_literal: true

RSpec.shared_examples 'kyc shipping info attributes examples' do
  describe 'when shipping info attributes' do
    let(:shipping_info) do
      request.shipping_first_name     = Faker::Name.first_name
      request.shipping_last_name      = Faker::Name.last_name
      request.shipping_customer_email = Faker::Internet.email
      request.shipping_address1       = Faker::Address.street_address
      request.shipping_address2       = Faker::Address.secondary_address
      request.shipping_city           = Faker::Address.city
      request.shipping_province       = Faker::Address.state
      request.shipping_zip_code       = Faker::Address.zip_code
      request.shipping_country        = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      request.shipping_phone1         = '12345678'

      request
    end

    it 'with shipping first name' do
      shipping_info.shipping_first_name = name = Faker::Name.first_name
      expect(shipping_info.shipping_first_name).to eq name
    end

    it 'with shipping last name' do
      shipping_info.shipping_last_name = name = Faker::Name.last_name
      expect(shipping_info.shipping_last_name).to eq name
    end

    it 'with valid shipping email' do
      shipping_info.shipping_customer_email = email = Faker::Internet.email
      expect(shipping_info.shipping_customer_email).to eq email
    end

    it 'with invalid shipping email' do
      expect do
        shipping_info.shipping_customer_email = 'invalid-email'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with shipping address1' do
      shipping_info.shipping_address1 = address = Faker::Address.street_address
      expect(shipping_info.shipping_address1).to eq address
    end

    it 'with shipping address2' do
      shipping_info.shipping_address2 = address = Faker::Address.secondary_address
      expect(shipping_info.shipping_address2).to eq address
    end

    it 'with shipping city' do
      shipping_info.shipping_city = city = Faker::Address.city
      expect(shipping_info.shipping_city).to eq city
    end

    it 'with shipping province' do
      shipping_info.shipping_province = province = Faker::Address.state
      expect(shipping_info.shipping_province).to eq province
    end

    it 'with shipping zip code' do
      shipping_info.shipping_zip_code = zip = Faker::Address.zip_code
      expect(shipping_info.shipping_zip_code).to eq zip
    end

    it 'with valid shipping country' do
      shipping_info.shipping_country = country = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      expect(shipping_info.shipping_country).to eq country
    end

    it 'with invalid shipping country' do
      expect { shipping_info.shipping_country = 'INVALID' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid shipping phone' do
      shipping_info.shipping_phone1 = phone = '12345678'
      expect(shipping_info.shipping_phone1).to eq phone
    end

    it 'with invalid shipping phone' do
      expect { shipping_info.shipping_phone1 = 'invalid-phone' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
