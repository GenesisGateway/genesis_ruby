require 'spec/genesis_ruby/stubs/api/requests/customer_address/billing_info_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes do
  let(:billing_info_attributes) { GenesisSpec::Stubs::Api::Requests::CustomerAddress::BillingInfoAttributesStub.new }

  describe 'has proper first_name accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_first_name = Faker::Name.first_name }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_first_name = first_name = Faker::Name.first_name

      expect(billing_info_attributes.billing_first_name).to eq(first_name)
    end
  end

  describe 'has proper last_name accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_last_name = Faker::Name.last_name }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_last_name = last_name = Faker::Name.last_name

      expect(billing_info_attributes.billing_last_name).to eq(last_name)
    end
  end

  describe 'has proper address1 accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_address1 = Faker::Address.street_address }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_address1 = address = Faker::Address.street_address

      expect(billing_info_attributes.billing_address1).to eq(address)
    end
  end

  describe 'has proper address2 accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_address2 = Faker::Address.street_address }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_address2 = address = Faker::Address.street_address

      expect(billing_info_attributes.billing_address2).to eq(address)
    end
  end

  describe 'has proper zip_code accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_zip_code = Faker::Address.zip_code }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_zip_code = zip_code = Faker::Address.zip_code

      expect(billing_info_attributes.billing_zip_code).to eq(zip_code)
    end
  end

  describe 'has proper city accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_city = Faker::Address.city }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_city = city = Faker::Address.city

      expect(billing_info_attributes.billing_city).to eq(city)
    end
  end

  describe 'has proper state accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_state = Faker::Address.state }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_state = state = Faker::Address.state

      expect(billing_info_attributes.billing_state).to eq(state)
    end
  end

  describe 'has proper country accessors' do
    it 'has setter' do
      expect { billing_info_attributes.billing_country = Faker::Address.country }.to_not raise_error
    end

    it 'has getter' do
      billing_info_attributes.billing_country = country = Faker::Address.country

      expect(billing_info_attributes.billing_country).to eq(country)
    end
  end

  it 'has hash billing_address_parameters_structure' do
    expect(billing_info_attributes.billing_address_parameters_structure).to be_kind_of(Hash)
  end
end
