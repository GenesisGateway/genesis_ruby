# frozen_string_literal: true

RSpec.shared_examples 'kyc billing info attributes examples' do
  describe 'when billing info attributes' do
    let(:billing_info) do
      request.billing_first_name      = Faker::Name.first_name
      request.billing_last_name       = Faker::Name.last_name
      request.billing_customer_email  = Faker::Internet.email
      request.billing_address1        = Faker::Address.street_address
      request.billing_address2        = Faker::Address.secondary_address
      request.billing_city            = Faker::Address.city
      request.billing_province        = Faker::Address.state
      request.billing_zip_code        = Faker::Address.zip_code
      request.billing_country         = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      request.billing_phone1          = '12345678'
      request.billing_birth_date      = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.billing_gender          = GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample

      request
    end

    it 'with billing first name' do
      billing_info.billing_first_name = name = Faker::Name.first_name
      expect(billing_info.billing_first_name).to eq name
    end

    it 'with billing last name' do
      billing_info.billing_last_name = name = Faker::Name.last_name
      expect(billing_info.billing_last_name).to eq name
    end

    it 'with valid billing email' do
      billing_info.billing_customer_email = email = Faker::Internet.email
      expect(billing_info.billing_customer_email).to eq email
    end

    it 'with invalid billing email' do
      expect { billing_info.billing_customer_email = 'invalid-email' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with billing address1' do
      billing_info.billing_address1 = address = Faker::Address.street_address
      expect(billing_info.billing_address1).to eq address
    end

    it 'with billing address2' do
      billing_info.billing_address2 = address = Faker::Address.secondary_address
      expect(billing_info.billing_address2).to eq address
    end

    it 'with billing city' do
      billing_info.billing_city = city = Faker::Address.city
      expect(billing_info.billing_city).to eq city
    end

    it 'with billing province' do
      billing_info.billing_province = province = Faker::Address.state
      expect(billing_info.billing_province).to eq province
    end

    it 'with billing zip code' do
      billing_info.billing_zip_code = zip = Faker::Address.zip_code
      expect(billing_info.billing_zip_code).to eq zip
    end

    it 'with valid billing country' do
      billing_info.billing_country = country = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      expect(billing_info.billing_country).to eq country
    end

    it 'with invalid billing country' do
      expect { billing_info.billing_country = 'INVALID' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid billing phone' do
      billing_info.billing_phone1 = phone = '12345678'
      expect(billing_info.billing_phone1).to eq phone
    end

    it 'with invalid billing phone' do
      expect { billing_info.billing_phone1 = 'invalid-phone' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with billing birth date' do
      billing_info.billing_birth_date = date = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      expect(billing_info.billing_birth_date).to eq date
    end

    it 'with valid billing gender' do
      billing_info.billing_gender = gender = GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample
      expect(billing_info.billing_gender).to eq gender
    end

    it 'with invalid billing gender' do
      expect { billing_info.billing_gender = 'INVALID' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
