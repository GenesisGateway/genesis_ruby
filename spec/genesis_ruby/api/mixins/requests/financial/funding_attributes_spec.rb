# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/funding_attributes_stub'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::FundingAttributes do
  let(:funding) { GenesisSpec::Stubs::Api::Requests::Financial::FundingAttributesStub.new }
  let(:identifier_type) { 'type' }
  let(:business_application_identifier) { 'identifier' }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:country) { Faker::Address.country_code }
  let(:account_number) { Faker::Internet.uuid }
  let(:account_number_type) { 'type' }
  let(:address) { Faker::Address.full_address }
  let(:address2) { Faker::Address.secondary_address }
  let(:street_name) { Faker::Address.street_name }
  let(:zip_code) { Faker::Address.zip_code }
  let(:state) { Faker::Address.state }
  let(:city) { Faker::Address.city }
  let(:person_type) { GenesisRuby::Api::Constants::Transactions::Parameters::Funding::PersonTypes.all.sample }

  describe 'when funding_identifier_type' do
    it 'with setter' do
      expect { funding.funding_identifier_type = identifier_type }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_identifier_type = identifier_type

      expect(funding.funding_identifier_type).to eq identifier_type
    end
  end

  describe 'when funding_business_application_identifier' do
    it 'with setter' do
      expect { funding.funding_business_application_identifier = business_application_identifier }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_business_application_identifier = business_application_identifier

      expect(funding.funding_business_application_identifier).to eq business_application_identifier
    end
  end

  describe 'when funding_receiver_first_name' do
    it 'with setter' do
      expect { funding.funding_receiver_first_name = first_name }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_first_name = first_name

      expect(funding.funding_receiver_first_name).to eq first_name
    end
  end

  describe 'when funding_receiver_last_name' do
    it 'with setter' do
      expect { funding.funding_receiver_last_name = last_name }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_last_name = last_name

      expect(funding.funding_receiver_last_name).to eq last_name
    end
  end

  describe 'when funding_receiver_country' do
    it 'with setter' do
      expect { funding.funding_receiver_country = country }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_country = country

      expect(funding.funding_receiver_country).to eq country
    end
  end

  describe 'when funding_receiver_account_number' do
    it 'with setter' do
      expect { funding.funding_receiver_account_number = account_number }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_account_number = account_number

      expect(funding.funding_receiver_account_number).to eq account_number
    end
  end

  describe 'when funding_receiver_account_number_type' do
    it 'with setter' do
      expect { funding.funding_receiver_account_number_type = account_number_type }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_account_number_type = account_number_type

      expect(funding.funding_receiver_account_number_type).to eq account_number_type
    end
  end

  describe 'when funding_receiver_address' do
    it 'with setter' do
      expect { funding.funding_receiver_address = address }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_address = address

      expect(funding.funding_receiver_address).to eq address
    end
  end

  describe 'when funding_receiver_address2' do
    it 'with setter' do
      expect { funding.funding_receiver_address2 = address2 }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_address2 = address2

      expect(funding.funding_receiver_address2).to eq address2
    end
  end

  describe 'when funding_receiver_street_name' do
    it 'with setter' do
      expect { funding.funding_receiver_street_name = street_name }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_street_name = street_name

      expect(funding.funding_receiver_street_name).to eq street_name
    end
  end

  describe 'when funding_receiver_zip_code' do
    it 'with setter' do
      expect { funding.funding_receiver_zip_code = zip_code }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_zip_code = zip_code

      expect(funding.funding_receiver_zip_code).to eq zip_code
    end
  end

  describe 'when funding_receiver_type' do
    it 'with setter' do
      expect { funding.funding_receiver_type = person_type }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_type = person_type

      expect(funding.funding_receiver_type).to eq person_type
    end

    it 'with invalid value' do
      expect { funding.funding_receiver_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with nil value' do
      expect { funding.funding_receiver_type = nil }.to_not raise_error
    end

    it 'with nil value getter' do
      funding.funding_receiver_type = nil

      expect(funding.funding_receiver_type).to be_nil
    end

    it 'with empty value' do
      expect { funding.funding_receiver_type = '' }.to_not raise_error
    end

    it 'with empty value getter' do
      funding.funding_receiver_type = ''

      expect(funding.funding_receiver_type).to be_nil
    end
  end

  describe 'when funding_receiver_state' do
    it 'with setter' do
      expect { funding.funding_receiver_state = state }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_state = state

      expect(funding.funding_receiver_state).to eq state
    end
  end

  describe 'when funding_receiver_city' do
    it 'with setter' do
      expect { funding.funding_receiver_city = city }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_receiver_city = city

      expect(funding.funding_receiver_city).to eq city
    end
  end

  describe 'when funding_sender_name' do
    let(:name) { "#{first_name} #{last_name}" }

    it 'with setter' do
      expect { funding.funding_sender_name = name }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_name = name

      expect(funding.funding_sender_name).to eq name
    end
  end

  describe 'when funding_sender_type' do
    it 'with setter' do
      expect { funding.funding_sender_type = person_type }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_type = person_type

      expect(funding.funding_sender_type).to eq person_type
    end

    it 'with invalid value' do
      expect { funding.funding_sender_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with nil value' do
      expect { funding.funding_sender_type = nil }.to_not raise_error
    end

    it 'with nil value getter' do
      funding.funding_sender_type = nil

      expect(funding.funding_sender_type).to be_nil
    end

    it 'with empty value' do
      expect { funding.funding_sender_type = '' }.to_not raise_error
    end

    it 'with empty value getter' do
      funding.funding_sender_type = ''

      expect(funding.funding_sender_type).to be_nil
    end
  end

  describe 'when funding_sender_reference_number' do
    it 'with setter' do
      expect { funding.funding_sender_reference_number = account_number }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_reference_number = account_number

      expect(funding.funding_sender_reference_number).to eq account_number
    end
  end

  describe 'when funding_sender_country' do
    it 'with setter' do
      expect { funding.funding_sender_country = country }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_country = country

      expect(funding.funding_sender_country).to eq country
    end
  end

  describe 'when funding_sender_address' do
    it 'with setter' do
      expect { funding.funding_sender_address = address }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_address = address

      expect(funding.funding_sender_address).to eq address
    end
  end

  describe 'when funding_sender_state' do
    it 'with setter' do
      expect { funding.funding_sender_state = state }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_state = state

      expect(funding.funding_sender_state).to eq state
    end
  end

  describe 'when funding_sender_city' do
    it 'with setter' do
      expect { funding.funding_sender_city = city }.to_not raise_error
    end

    it 'with getter' do
      funding.funding_sender_city = city

      expect(funding.funding_sender_city).to eq city
    end
  end

  describe 'when proper structure' do
    it 'with proper request structure type' do
      expect(funding.funding_attributes_structure).to be_a Hash
    end

    it 'with proper validation structure type' do
      expect(funding.funding_attributes_field_validations).to be_a Hash
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
