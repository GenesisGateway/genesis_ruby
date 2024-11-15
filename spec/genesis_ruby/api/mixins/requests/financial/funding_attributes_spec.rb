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
  let(:state) { Faker::Address.state }
  let(:city) { Faker::Address.city }

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
