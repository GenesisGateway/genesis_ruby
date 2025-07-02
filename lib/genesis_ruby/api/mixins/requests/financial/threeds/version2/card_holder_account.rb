# frozen_string_literal: true

# rubocop:disable Layout/LineLength
require 'genesis_ruby/api/constants/date_time_formats'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/card_holder_account/update_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/card_holder_account/password_change_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/card_holder_account/shipping_address_usage_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/card_holder_account/suspicious_activity_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/card_holder_account/registration_indicators'
# rubocop:enable Layout/LineLength

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 Card holder Account
              module CardHolderAccount # rubocop:disable Metrics/ModuleLength

                attr_reader :threeds_v2_card_holder_account_transactions_activity_last24_hours,
                            :threeds_v2_card_holder_account_transactions_activity_previous_year,
                            :threeds_v2_card_holder_account_provision_attempts_last24_hours,
                            :threeds_v2_card_holder_account_purchases_count_last6_months
                attr_accessor :threeds_v2_card_holder_account_update_indicator,
                              :threeds_v2_card_holder_account_password_change_indicator,
                              :threeds_v2_card_holder_account_shipping_address_usage_indicator,
                              :threeds_v2_card_holder_account_suspicious_activity_indicator,
                              :threeds_v2_card_holder_account_registration_indicator

                # Date that the cardholder opened the account with the 3DS Requester.
                def threeds_v2_card_holder_account_creation_date
                  @threeds_v2_card_holder_account_creation_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # Date that the cardholder opened the account with the 3DS Requester.
                def threeds_v2_card_holder_account_creation_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # Date that the cardholder’s account with the 3DS Requester was last changed
                def threeds_v2_card_holder_account_last_change_date
                  @threeds_v2_card_holder_account_last_change_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # Date that the cardholder’s account with the 3DS Requester was last changed
                def threeds_v2_card_holder_account_last_change_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # Date that cardholder’s account with the 3DS Requester had a password change or account reset
                def threeds_v2_card_holder_account_password_change_date
                  @threeds_v2_card_holder_account_password_change_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # Date that cardholder’s account with the 3DS Requester had a password change or account reset
                def threeds_v2_card_holder_account_password_change_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # Date when the shipping address used for this transaction was first used with the 3DS Requester
                def threeds_v2_card_holder_account_shipping_address_date_first_used
                  @threeds_v2_card_holder_account_shipping_address_date_first_used&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # Date when the shipping address used for this transaction was first used with the 3DS Requester
                def threeds_v2_card_holder_account_shipping_address_date_first_used=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # Number of transactions (successful and abandoned) for this cardholder account
                def threeds_v2_card_holder_account_transactions_activity_last24_hours=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Number of transactions (successful and abandoned) for this cardholder account
                def threeds_v2_card_holder_account_transactions_activity_previous_year=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Number of Add Card attempts in the last 24 hours
                def threeds_v2_card_holder_account_provision_attempts_last24_hours=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Number of purchases with this cardholder account during the previous six months
                def threeds_v2_card_holder_account_purchases_count_last6_months=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Date that the cardholder opened the account with the 3DS Requester.
                def threeds_v2_card_holder_account_registration_date
                  @threeds_v2_card_holder_account_registration_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # Date that the payment account was enrolled in the cardholder’s account with the 3DS Requester
                def threeds_v2_card_holder_account_registration_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                protected

                # Card Holder field validations structure
                def threeds_card_holder_field_validations # rubocop:disable Metrics/MethodLength
                  {
                    threeds_v2_card_holder_account_update_indicator:                 Api::Constants::Transactions::
                        Parameters::Threeds::Version2::CardHolderAccount::UpdateIndicators.all,
                    threeds_v2_card_holder_account_password_change_indicator:        Api::Constants::Transactions::
                        Parameters::Threeds::Version2::CardHolderAccount::PasswordChangeIndicators.all,
                    threeds_v2_card_holder_account_shipping_address_usage_indicator: Api::Constants::Transactions::
                        Parameters::Threeds::Version2::CardHolderAccount::ShippingAddressUsageIndicators.all,
                    threeds_v2_card_holder_account_suspicious_activity_indicator:    Api::Constants::Transactions::
                        Parameters::Threeds::Version2::CardHolderAccount::SuspiciousActivityIndicators.all,
                    threeds_v2_card_holder_account_registration_indicator:           Api::Constants::Transactions::
                        Parameters::Threeds::Version2::CardHolderAccount::RegistrationIndicators.all
                  }
                end

                def validate_threeds_card_holder_dates
                  today   = DateTime.now
                  message = 'must be a valid date in the past.'

                  validate_creation_date today, message
                  validate_last_change_date today, message
                  validate_password_change_date today, message
                  validate_shipping_address_date_first_used today, message
                  validate_registration_date today, message
                end

                # Request CardHolder Account Attributes structure
                # rubocop:disable Layout/LineLength, Metrics/MethodLength
                def card_holder_account_attributes
                  {
                    creation_date:                       threeds_v2_card_holder_account_creation_date,
                    update_indicator:                    threeds_v2_card_holder_account_update_indicator,
                    last_change_date:                    threeds_v2_card_holder_account_last_change_date,
                    password_change_indicator:           threeds_v2_card_holder_account_password_change_indicator,
                    password_change_date:                threeds_v2_card_holder_account_password_change_date,
                    shipping_address_usage_indicator:    threeds_v2_card_holder_account_shipping_address_usage_indicator,
                    shipping_address_date_first_used:    threeds_v2_card_holder_account_shipping_address_date_first_used,
                    transactions_activity_last_24_hours: threeds_v2_card_holder_account_transactions_activity_last24_hours,
                    transactions_activity_previous_year: threeds_v2_card_holder_account_transactions_activity_previous_year,
                    provision_attempts_last_24_hours:    threeds_v2_card_holder_account_provision_attempts_last24_hours,
                    purchases_count_last_6_months:       threeds_v2_card_holder_account_purchases_count_last6_months,
                    suspicious_activity_indicator:       threeds_v2_card_holder_account_suspicious_activity_indicator,
                    registration_indicator:              threeds_v2_card_holder_account_registration_indicator,
                    registration_date:                   threeds_v2_card_holder_account_registration_date
                  }
                end
                # rubocop:enable Layout/LineLength, Metrics/MethodLength

                private

                # Creation Date Validation
                def validate_creation_date(less_than, message)
                  return unless @threeds_v2_card_holder_account_creation_date.is_a? DateTime

                  return if @threeds_v2_card_holder_account_creation_date < less_than

                  raise ParameterError, "Card Holder Account Creation Date #{message}"
                end

                # Last Change Date validation
                def validate_last_change_date(less_than, message)
                  return unless @threeds_v2_card_holder_account_last_change_date.is_a? DateTime

                  return if @threeds_v2_card_holder_account_last_change_date < less_than

                  raise ParameterError, "Card Holder Account Last Change Date #{message}"
                end

                # Password Change Date validation
                def validate_password_change_date(less_than, message)
                  return unless @threeds_v2_card_holder_account_password_change_date.is_a? DateTime

                  return if @threeds_v2_card_holder_account_password_change_date < less_than

                  raise ParameterError, "Card Holder Account Password Change Date #{message}"
                end

                # Shipping Address Date First Used validation
                def validate_shipping_address_date_first_used(less_than, message)
                  return unless @threeds_v2_card_holder_account_shipping_address_date_first_used.is_a? DateTime

                  return if @threeds_v2_card_holder_account_shipping_address_date_first_used < less_than

                  raise ParameterError, "Card Holder Account Shipping Address Date First Used #{message}"
                end

                # Registration Date validations
                def validate_registration_date(less_than, message)
                  return unless @threeds_v2_card_holder_account_registration_date.is_a? DateTime

                  return if @threeds_v2_card_holder_account_registration_date < less_than

                  raise ParameterError, "Card Holder Account Registration Date #{message}"
                end

              end
            end
          end
        end
      end
    end
  end
end
