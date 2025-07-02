# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/dynamic_descriptor_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::DynamicDescriptorAttributes do
  let(:dynamic_descriptor) { GenesisSpec::Stubs::Api::Requests::Financial::DynamicDescriptorAttributesStub.new }

  describe 'when dynamic descriptor merchant name' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_name = name = Faker::String.random length: 25

      expect(dynamic_descriptor.dynamic_descriptor_merchant_name).to eq name
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_name = Faker::String.random length: 26
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_name = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_name).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant city' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_city = city = Faker::String.random length: 13

      expect(dynamic_descriptor.dynamic_descriptor_merchant_city).to eq city
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_city = Faker::String.random length: 14
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_name = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_city).to eq nil
    end
  end

  describe 'when dynamic descriptor sub merchant id' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_sub_merchant_id = merchant_id = Faker::String.random length: 15

      expect(dynamic_descriptor.dynamic_descriptor_sub_merchant_id).to eq merchant_id
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_sub_merchant_id = Faker::String.random length: 16
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_sub_merchant_id = ''

      expect(dynamic_descriptor.dynamic_descriptor_sub_merchant_id).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant country' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_country = country = Faker::Address.country_code

      expect(dynamic_descriptor.dynamic_descriptor_merchant_country).to eq country
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_country = Faker::String.random length: 4
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_country = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_country).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant state' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_state = state = Faker::Address.state_abbr

      expect(dynamic_descriptor.dynamic_descriptor_merchant_state).to eq state
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_state = Faker::String.random length: 4
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_state = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_state).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant zip code' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_zip_code = state = Faker::Address.state_abbr

      expect(dynamic_descriptor.dynamic_descriptor_merchant_zip_code).to eq state
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_zip_code = Faker::String.random length: 11
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_zip_code = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_zip_code).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant address' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_address = address = Faker::Address.street_address

      expect(dynamic_descriptor.dynamic_descriptor_merchant_address).to eq address
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_address = Faker::String.random length: 49
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_address = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_address).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant url' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_url = url = Faker::Internet.url

      expect(dynamic_descriptor.dynamic_descriptor_merchant_url).to eq url
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_url = Faker::String.random length: 61
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_url = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_url).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant phone' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_phone = phone = Faker::PhoneNumber.cell_phone

      expect(dynamic_descriptor.dynamic_descriptor_merchant_phone).to eq phone
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_phone = Faker::String.random length: 17
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_phone = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_phone).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant geo coordinates' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_geo_coordinates = coordinates =
        "#{Faker::Address.longitude.to_s[..7]}, #{Faker::Address.latitude.to_s[..7]}"

      expect(dynamic_descriptor.dynamic_descriptor_merchant_geo_coordinates).to eq coordinates
    end

    it 'with invalid min value' do
      expect { dynamic_descriptor.dynamic_descriptor_merchant_geo_coordinates = 'invalid' }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid max value' do
      expect { dynamic_descriptor.dynamic_descriptor_merchant_geo_coordinates = Faker::String.random(length: 21) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when dynamic descriptor merchant service city' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_city = city = Faker::String.random length: 13

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_city).to eq city
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_service_city = Faker::String.random length: 14
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_city = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_city).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant service country' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_country = country = Faker::Address.country_code

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_country).to eq country
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_service_country = Faker::String.random length: 4
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_country = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_country).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant service state' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_state = state = Faker::Address.state_abbr

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_state).to eq state
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_service_state = Faker::String.random length: 4
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_state = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_state).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant service zip code' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_zip_code = zip_code = Faker::Address.zip_code

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_zip_code).to eq zip_code
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_service_zip_code = Faker::String.random length: 11
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_zip_code = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_zip_code).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant service phone' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_phone = phone = Faker::PhoneNumber.cell_phone

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_phone).to eq phone
    end

    it 'with invalid value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_service_phone = Faker::String.random length: 17
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with empty value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_phone = ''

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_phone).to eq nil
    end
  end

  describe 'when dynamic descriptor merchant service geo coordinates' do
    it 'with valid value' do
      dynamic_descriptor.dynamic_descriptor_merchant_service_geo_coordinates = coordinates =
        "#{Faker::Address.longitude.to_s[..7]}, #{Faker::Address.latitude.to_s[..7]}"

      expect(dynamic_descriptor.dynamic_descriptor_merchant_service_geo_coordinates).to eq coordinates
    end

    it 'with invalid min value' do
      expect { dynamic_descriptor.dynamic_descriptor_merchant_service_geo_coordinates = 'invalid' }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid max value' do
      expect do
        dynamic_descriptor.dynamic_descriptor_merchant_service_geo_coordinates = Faker::String.random(length: 21)
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'when request structure' do
    expect(dynamic_descriptor.dynamic_descriptor_structure).to be_kind_of Hash
  end
end
