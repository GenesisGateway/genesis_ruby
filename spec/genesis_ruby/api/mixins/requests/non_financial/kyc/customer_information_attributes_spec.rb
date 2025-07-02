# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/customer_information_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::CustomerInformationAttributes do
  let(:customer_information_attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::CustomerInformationAttributesStub.new
  end

  let(:test_data) do
    {
      first_name:      Faker::Name.first_name,
      middle_name:     Faker::Name.middle_name,
      last_name:       Faker::Name.last_name,
      customer_email:  Faker::Internet.email,
      address1:        Faker::Address.street_address,
      address2:        Faker::Address.secondary_address,
      city:            Faker::Address.city,
      province:        Faker::Address.state_abbr,
      zip_code:        Faker::Address.zip_code,
      country:         Faker::Address.country,
      phone1:          Faker::PhoneNumber.phone_number,
      phone2:          Faker::PhoneNumber.phone_number,
      birth_date:      Faker::Date.birthday.strftime('%d-%m-%Y'),
      document_type:   GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentTypes.all.sample,
      document_number: Faker::Number.number(digits: 9).to_s,
      gender:          GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample
    }
  end

  describe 'customer information structure' do
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      customer_information_attributes.first_name      = test_data['first_name']
      customer_information_attributes.middle_name     = test_data['middle_name']
      customer_information_attributes.last_name       = test_data['last_name']
      customer_information_attributes.customer_email  = test_data['customer_email']
      customer_information_attributes.address1        = test_data['address1']
      customer_information_attributes.address2        = test_data['address2']
      customer_information_attributes.city            = test_data['city']
      customer_information_attributes.province        = test_data['province']
      customer_information_attributes.zip_code        = test_data['zip_code']
      customer_information_attributes.country         = test_data['country']
      customer_information_attributes.phone1          = test_data['phone1']
      customer_information_attributes.phone2          = test_data['phone2']
      customer_information_attributes.birth_date      = test_data['birth_date']

      customer_information_attributes.document_type   = test_data['document_type']
      customer_information_attributes.document_number = test_data['document_number']
      customer_information_attributes.gender          = test_data['gender']

      expected_hash = {
        first_name:      test_data['first_name'],
        middle_name:     test_data['middle_name'],
        last_name:       test_data['last_name'],
        customer_email:  test_data['customer_email'],
        address1:        test_data['address1'],
        address2:        test_data['address2'],
        city:            test_data['city'],
        province:        test_data['province'],
        zip_code:        test_data['zip_code'],
        country:         test_data['country'],
        phone1:          test_data['phone1'],
        phone2:          test_data['phone2'],
        birth_date:      test_data['birth_date'],
        document_type:   test_data['document_type'],
        document_number: test_data['document_number'],
        gender:          test_data['gender']
      }

      structure = customer_information_attributes.public_send(:customer_information_structure)
      expect(structure).to eq(expected_hash)
    end
  end
end
