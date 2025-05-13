require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/customer_information_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::CustomerInformationAttributes do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:customer_information_attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::CustomerInformationAttributesStub.new
  end

  let(:first_name)      { Faker::Name.first_name }
  let(:middle_name)     { Faker::Name.middle_name }
  let(:last_name)       { Faker::Name.last_name }
  let(:customer_email)  { Faker::Internet.email }
  let(:address1)        { Faker::Address.street_address }
  let(:address2)        { Faker::Address.secondary_address }
  let(:city)            { Faker::Address.city }
  let(:province)        { Faker::Address.state_abbr }
  let(:zip_code)        { Faker::Address.zip_code }
  let(:country)         { Faker::Address.country }
  let(:phone1)          { Faker::PhoneNumber.phone_number }
  let(:phone2)          { Faker::PhoneNumber.phone_number }
  let(:birth_date)      { Faker::Date.birthday.strftime('%d-%m-%Y') }
  let(:document_type)   { GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentTypes.all.sample }
  let(:document_number) { Faker::Number.number(digits: 9).to_s }
  let(:gender)          { GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample }

  describe 'customer information structure' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      customer_information_attributes.first_name      = first_name
      customer_information_attributes.middle_name     = middle_name
      customer_information_attributes.last_name       = last_name
      customer_information_attributes.customer_email  = customer_email
      customer_information_attributes.address1        = address1
      customer_information_attributes.address2        = address2
      customer_information_attributes.city            = city
      customer_information_attributes.province        = province
      customer_information_attributes.zip_code        = zip_code
      customer_information_attributes.country         = country
      customer_information_attributes.phone1          = phone1
      customer_information_attributes.phone2          = phone2
      customer_information_attributes.birth_date      = birth_date

      customer_information_attributes.document_type   = document_type
      customer_information_attributes.document_number = document_number
      customer_information_attributes.gender          = gender

      expected_hash = {
        first_name:      first_name,
        middle_name:     middle_name,
        last_name:       last_name,
        customer_email:  customer_email,
        address1:        address1,
        address2:        address2,
        city:            city,
        province:        province,
        zip_code:        zip_code,
        country:         country,
        phone1:          phone1,
        phone2:          phone2,
        birth_date:      birth_date,
        document_type:   document_type,
        document_number: document_number,
        gender:          gender
      }

      structure = customer_information_attributes.public_send(:customer_information_structure)
      expect(structure).to eq(expected_hash)
    end
  end
end
