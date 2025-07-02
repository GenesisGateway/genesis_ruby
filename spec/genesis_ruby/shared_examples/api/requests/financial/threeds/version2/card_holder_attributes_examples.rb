# frozen_string_literal: true

RSpec.shared_examples 'card holder date attributes examples' do
  describe 'when threeds card holder date validations' do
    let(:test_date) { Faker::Date.forward(days: 1).strftime('%d-%m-%Y') }

    it 'with invalid threeds_v2_card_holder_account_creation_date' do
      request.threeds_v2_card_holder_account_creation_date = test_date

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid threeds_v2_card_holder_account_last_change_date' do
      request.threeds_v2_card_holder_account_last_change_date = test_date

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid threeds_v2_card_holder_account_password_change_date' do
      request.threeds_v2_card_holder_account_password_change_date = test_date

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid threeds_v2_card_holder_account_shipping_address_date_first_used' do
      request.threeds_v2_card_holder_account_shipping_address_date_first_used = test_date

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid threeds_v2_card_holder_account_registration_date' do
      request.threeds_v2_card_holder_account_registration_date = test_date

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
