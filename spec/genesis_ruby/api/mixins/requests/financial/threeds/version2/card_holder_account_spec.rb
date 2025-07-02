# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/card_holder_account_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::CardHolderAccount do
  let(:date) { Faker::Date.in_date_period }
  let(:in_period_date) { date.strftime('%Y-%m-%d') }
  let(:genesis_format_date) { date.strftime(GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS) }
  let(:number_positive) { Faker::Number.positive.to_i }
  let(:card_holder_account) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::CardHolderAccountStub.new
  end

  describe 'when threeds_v2_card_holder_account_creation_date' do
    it 'with default value' do
      expect(card_holder_account.threeds_v2_card_holder_account_creation_date).to eq nil
    end

    it 'with empty date' do
      card_holder_account.threeds_v2_card_holder_account_creation_date = in_period_date
      card_holder_account.threeds_v2_card_holder_account_creation_date = ''

      expect(card_holder_account.threeds_v2_card_holder_account_creation_date).to eq nil
    end

    it 'with valid date' do
      card_holder_account.threeds_v2_card_holder_account_creation_date = in_period_date

      expect(card_holder_account.threeds_v2_card_holder_account_creation_date).to eq genesis_format_date
    end

    it 'with invalid date' do
      expect do
        card_holder_account.threeds_v2_card_holder_account_creation_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_card_holder_account_update_indicator' do
    it 'with setter' do
      expect { card_holder_account.threeds_v2_card_holder_account_update_indicator = Faker::Lorem.word }
        .to_not raise_error
    end

    it 'with getter' do
      card_holder_account.threeds_v2_card_holder_account_update_indicator = indicator = 'current_transaction'

      expect(card_holder_account.threeds_v2_card_holder_account_update_indicator).to eq indicator
    end

    it 'with empty indicator' do
      card_holder_account.threeds_v2_card_holder_account_update_indicator = ''

      expect(card_holder_account.threeds_v2_card_holder_account_update_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_card_holder_account_last_change_date' do
    it 'with default value' do
      expect(card_holder_account.threeds_v2_card_holder_account_last_change_date).to eq nil
    end

    it 'with empty date' do
      card_holder_account.threeds_v2_card_holder_account_last_change_date = in_period_date
      card_holder_account.threeds_v2_card_holder_account_last_change_date = ''

      expect(card_holder_account.threeds_v2_card_holder_account_last_change_date).to eq nil
    end

    it 'with valid date' do
      card_holder_account.threeds_v2_card_holder_account_last_change_date = in_period_date

      expect(card_holder_account.threeds_v2_card_holder_account_last_change_date).to eq genesis_format_date
    end

    it 'with invalid date' do
      expect do
        card_holder_account.threeds_v2_card_holder_account_last_change_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_card_holder_account_password_change_indicator' do
    it 'with setter' do
      expect { card_holder_account.threeds_v2_card_holder_account_password_change_indicator = Faker::Lorem.word }
        .to_not raise_error
    end

    it 'with getter' do
      card_holder_account.threeds_v2_card_holder_account_password_change_indicator = indicator = 'no_change'

      expect(card_holder_account.threeds_v2_card_holder_account_password_change_indicator).to eq indicator
    end

    it 'with empty indicator' do
      card_holder_account.threeds_v2_card_holder_account_password_change_indicator = ''

      expect(card_holder_account.threeds_v2_card_holder_account_password_change_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_card_holder_account_password_change_date' do
    it 'with default value' do
      expect(card_holder_account.threeds_v2_card_holder_account_password_change_date).to eq nil
    end

    it 'with empty date' do
      card_holder_account.threeds_v2_card_holder_account_password_change_date = in_period_date
      card_holder_account.threeds_v2_card_holder_account_password_change_date = ''

      expect(card_holder_account.threeds_v2_card_holder_account_password_change_date).to eq nil
    end

    it 'with valid date' do
      card_holder_account.threeds_v2_card_holder_account_password_change_date = in_period_date

      expect(card_holder_account.threeds_v2_card_holder_account_password_change_date).to eq genesis_format_date
    end

    it 'with invalid date' do
      expect do
        card_holder_account.threeds_v2_card_holder_account_password_change_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_card_holder_account_shipping_address_usage_indicator' do
    it 'with setter' do
      expect { card_holder_account.threeds_v2_card_holder_account_shipping_address_usage_indicator = Faker::Lorem.word }
        .to_not raise_error
    end

    it 'with getter' do
      card_holder_account.threeds_v2_card_holder_account_shipping_address_usage_indicator = indicator =
        'current_transaction'

      expect(card_holder_account.threeds_v2_card_holder_account_shipping_address_usage_indicator).to eq indicator
    end

    it 'with empty indicator' do
      card_holder_account.threeds_v2_card_holder_account_shipping_address_usage_indicator = ''

      expect(card_holder_account.threeds_v2_card_holder_account_shipping_address_usage_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_card_holder_account_shipping_address_date_first_used' do
    it 'with default value' do
      expect(card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used).to eq nil
    end

    it 'with empty date' do
      card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used = in_period_date
      card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used = ''

      expect(card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used).to eq nil
    end

    it 'with valid date' do
      card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used = in_period_date

      expect(
        card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used
      ).to eq(genesis_format_date)
    end

    it 'with invalid date' do
      expect do
        card_holder_account.threeds_v2_card_holder_account_shipping_address_date_first_used = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_card_holder_account_transactions_activity_last24_hours' do
    it 'with integer count' do
      card_holder_account.threeds_v2_card_holder_account_transactions_activity_last24_hours = number_positive

      expect(
        card_holder_account.threeds_v2_card_holder_account_transactions_activity_last24_hours
      ).to eq number_positive
    end

    it 'with string count' do
      card_holder_account.threeds_v2_card_holder_account_transactions_activity_last24_hours = number_positive.to_s

      expect(
        card_holder_account.threeds_v2_card_holder_account_transactions_activity_last24_hours
      ).to eq number_positive
    end

    it 'with empty count' do
      card_holder_account.threeds_v2_card_holder_account_transactions_activity_last24_hours = ''

      expect(card_holder_account.threeds_v2_card_holder_account_transactions_activity_last24_hours).to eq nil
    end
  end

  describe 'when threeds_v2_card_holder_account_transactions_activity_previous_year' do
    it 'with integer count' do
      card_holder_account.threeds_v2_card_holder_account_transactions_activity_previous_year = number_positive

      expect(
        card_holder_account.threeds_v2_card_holder_account_transactions_activity_previous_year
      ).to eq number_positive
    end

    it 'with string count' do
      card_holder_account.threeds_v2_card_holder_account_transactions_activity_previous_year = number_positive.to_s

      expect(
        card_holder_account.threeds_v2_card_holder_account_transactions_activity_previous_year
      ).to eq number_positive
    end

    it 'with empty count' do
      card_holder_account.threeds_v2_card_holder_account_transactions_activity_previous_year = ''

      expect(card_holder_account.threeds_v2_card_holder_account_transactions_activity_previous_year).to eq nil
    end
  end

  describe 'when threeds_v2_card_holder_account_provision_attempts_last24_hours' do
    it 'with integer count' do
      card_holder_account.threeds_v2_card_holder_account_provision_attempts_last24_hours = number_positive

      expect(
        card_holder_account.threeds_v2_card_holder_account_provision_attempts_last24_hours
      ).to eq number_positive
    end

    it 'with string count' do
      card_holder_account.threeds_v2_card_holder_account_provision_attempts_last24_hours = number_positive.to_s

      expect(
        card_holder_account.threeds_v2_card_holder_account_provision_attempts_last24_hours
      ).to eq number_positive
    end

    it 'with empty count' do
      card_holder_account.threeds_v2_card_holder_account_provision_attempts_last24_hours = ''

      expect(card_holder_account.threeds_v2_card_holder_account_provision_attempts_last24_hours).to eq nil
    end
  end

  describe 'when threeds_v2_card_holder_account_purchases_count_last6_months' do
    it 'with integer count' do
      card_holder_account.threeds_v2_card_holder_account_purchases_count_last6_months = number_positive

      expect(
        card_holder_account.threeds_v2_card_holder_account_purchases_count_last6_months
      ).to eq number_positive
    end

    it 'with string count' do
      card_holder_account.threeds_v2_card_holder_account_purchases_count_last6_months = number_positive.to_s

      expect(
        card_holder_account.threeds_v2_card_holder_account_purchases_count_last6_months
      ).to eq number_positive
    end

    it 'with empty count' do
      card_holder_account.threeds_v2_card_holder_account_purchases_count_last6_months = ''

      expect(card_holder_account.threeds_v2_card_holder_account_purchases_count_last6_months).to eq nil
    end
  end

  describe 'when threeds_v2_card_holder_account_suspicious_activity_indicator' do
    it 'with setter' do
      expect { card_holder_account.threeds_v2_card_holder_account_suspicious_activity_indicator = Faker::Lorem.word }
        .to_not raise_error
    end

    it 'with getter' do
      card_holder_account.threeds_v2_card_holder_account_suspicious_activity_indicator = indicator =
        'no_suspicious_observed'

      expect(card_holder_account.threeds_v2_card_holder_account_suspicious_activity_indicator).to eq indicator
    end

    it 'with empty indicator' do
      card_holder_account.threeds_v2_card_holder_account_suspicious_activity_indicator = ''

      expect(card_holder_account.threeds_v2_card_holder_account_suspicious_activity_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_card_holder_account_registration_indicator' do
    it 'with setter' do
      expect { card_holder_account.threeds_v2_card_holder_account_registration_indicator = Faker::Lorem.word }
        .to_not raise_error
    end

    it 'with getter' do
      card_holder_account.threeds_v2_card_holder_account_registration_indicator = indicator =
        'guest_checkout'

      expect(card_holder_account.threeds_v2_card_holder_account_registration_indicator).to eq indicator
    end

    it 'with empty indicator' do
      card_holder_account.threeds_v2_card_holder_account_registration_indicator = ''

      expect(card_holder_account.threeds_v2_card_holder_account_registration_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_card_holder_account_registration_date' do
    it 'with default value' do
      expect(card_holder_account.threeds_v2_card_holder_account_registration_date).to eq nil
    end

    it 'with empty date' do
      card_holder_account.threeds_v2_card_holder_account_registration_date = in_period_date
      card_holder_account.threeds_v2_card_holder_account_registration_date = ''

      expect(card_holder_account.threeds_v2_card_holder_account_registration_date).to eq nil
    end

    it 'with valid date' do
      card_holder_account.threeds_v2_card_holder_account_registration_date = in_period_date

      expect(card_holder_account.threeds_v2_card_holder_account_registration_date).to eq genesis_format_date
    end

    it 'with invalid date' do
      expect do
        card_holder_account.threeds_v2_card_holder_account_registration_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(card_holder_account.card_holder_account_attributes).to_not be_empty
  end

  it 'with card holder field validation structure' do
    expect(card_holder_account.threeds_card_holder_field_validations).to_not be_empty
  end
end
