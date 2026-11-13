# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/money_transfer_payout_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::MoneyTransferPayoutAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::MoneyTransferPayoutAttributesStub.new }

  describe 'money_transfer_sender_address_first_name' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_first_name = 'John'

      expect(attributes.money_transfer_sender_address_first_name).to eq('John')
    end
  end

  describe 'money_transfer_sender_address_last_name' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_last_name = 'Doe'

      expect(attributes.money_transfer_sender_address_last_name).to eq('Doe')
    end
  end

  describe 'money_transfer_sender_address_country' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_country = 'US'

      expect(attributes.money_transfer_sender_address_country).to eq('US')
    end
  end

  describe 'money_transfer_sender_address_city' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_city = 'Chicago'

      expect(attributes.money_transfer_sender_address_city).to eq('Chicago')
    end
  end

  describe 'money_transfer_sender_address_zip_code' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_zip_code = '60601'

      expect(attributes.money_transfer_sender_address_zip_code).to eq('60601')
    end
  end

  describe 'money_transfer_sender_address_address1' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_address1 = '1 Main Street'

      expect(attributes.money_transfer_sender_address_address1).to eq('1 Main Street')
    end
  end

  describe 'money_transfer_sender_address_state' do
    it 'stores the value set' do
      attributes.money_transfer_sender_address_state = 'IL'

      expect(attributes.money_transfer_sender_address_state).to eq('IL')
    end
  end

  describe 'money_transfer_receiver_first_name' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_first_name = 'Jane'

      expect(attributes.money_transfer_receiver_first_name).to eq('Jane')
    end
  end

  describe 'money_transfer_receiver_country' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_country = 'CA'

      expect(attributes.money_transfer_receiver_country).to eq('CA')
    end
  end

  describe 'money_transfer_sender_account_number' do
    it 'stores the value set' do
      attributes.money_transfer_sender_account_number = '1234567890'

      expect(attributes.money_transfer_sender_account_number).to eq('1234567890')
    end
  end

  describe 'money_transfer_service_provider_name' do
    it 'stores the value set' do
      attributes.money_transfer_service_provider_name = 'Provider'

      expect(attributes.money_transfer_service_provider_name).to eq('Provider')
    end
  end

  describe 'money_transfer_receiver_last_name' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_last_name = 'Roe'

      expect(attributes.money_transfer_receiver_last_name).to eq('Roe')
    end
  end

  describe 'money_transfer_receiver_city' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_city = 'Paris'

      expect(attributes.money_transfer_receiver_city).to eq('Paris')
    end
  end

  describe 'money_transfer_receiver_zip_code' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_zip_code = '75001'

      expect(attributes.money_transfer_receiver_zip_code).to eq('75001')
    end
  end

  describe 'money_transfer_receiver_address1' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_address1 = '1 Rue de Rivoli'

      expect(attributes.money_transfer_receiver_address1).to eq('1 Rue de Rivoli')
    end
  end

  describe 'money_transfer_receiver_state' do
    it 'stores the value set' do
      attributes.money_transfer_receiver_state = 'IDF'

      expect(attributes.money_transfer_receiver_state).to eq('IDF')
    end
  end

  describe 'money_transfer_type' do
    it 'accepts a valid option' do
      attributes.money_transfer_type = 'account_to_account'

      expect(attributes.money_transfer_type).to eq('account_to_account')
    end

    it 'rejects an invalid option' do
      expect { attributes.money_transfer_type = 'invalid_option' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'stores an empty string as nil' do
      attributes.money_transfer_type = ''

      expect(attributes.money_transfer_type).to be_nil
    end
  end

  describe 'money_transfer_sender_address_type' do
    it 'accepts a valid option' do
      attributes.money_transfer_sender_address_type = 'natural'

      expect(attributes.money_transfer_sender_address_type).to eq('natural')
    end

    it 'rejects an invalid option' do
      expect { attributes.money_transfer_sender_address_type = 'invalid_option' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'stores an empty string as nil' do
      attributes.money_transfer_sender_address_type = ''

      expect(attributes.money_transfer_sender_address_type).to be_nil
    end
  end

  describe 'money_transfer_receiver_type' do
    it 'accepts a valid option' do
      attributes.money_transfer_receiver_type = 'legal'

      expect(attributes.money_transfer_receiver_type).to eq('legal')
    end

    it 'rejects an invalid option' do
      expect { attributes.money_transfer_receiver_type = 'invalid_option' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'stores an empty string as nil' do
      attributes.money_transfer_receiver_type = ''

      expect(attributes.money_transfer_receiver_type).to be_nil
    end
  end

  describe 'money_transfer_sender_account_number_type' do
    it 'accepts a valid option' do
      attributes.money_transfer_sender_account_number_type = 'iban'

      expect(attributes.money_transfer_sender_account_number_type).to eq('iban')
    end

    it 'rejects an invalid option' do
      expect { attributes.money_transfer_sender_account_number_type = 'invalid_option' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'stores an empty string as nil' do
      attributes.money_transfer_sender_account_number_type = ''

      expect(attributes.money_transfer_sender_account_number_type).to be_nil
    end
  end

  describe 'money_transfer_source_of_funds' do
    it 'accepts a valid option' do
      attributes.money_transfer_source_of_funds = 'credit'

      expect(attributes.money_transfer_source_of_funds).to eq('credit')
    end

    it 'rejects an invalid option' do
      expect { attributes.money_transfer_source_of_funds = 'invalid_option' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'stores an empty string as nil' do
      attributes.money_transfer_source_of_funds = ''

      expect(attributes.money_transfer_source_of_funds).to be_nil
    end
  end

  describe 'money_transfer_sender_birth_date' do
    it 'round trips the date as DD-MM-YYYY' do
      attributes.money_transfer_sender_birth_date = '31-12-1990'

      expect(attributes.money_transfer_sender_birth_date).to eq('31-12-1990')
    end

    it 'stores nil as nil' do
      attributes.money_transfer_sender_birth_date = nil

      expect(attributes.money_transfer_sender_birth_date).to be_nil
    end
  end

  describe 'protected helpers' do
    it 'returns a Hash from the structure method' do
      expect(attributes.money_transfer_payout_attributes_structure).to be_a(Hash)
    end
  end
end
