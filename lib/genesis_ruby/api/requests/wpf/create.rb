require 'genesis_ruby/utils/transactions/wpf_types'
require 'genesis_ruby/api/constants/transactions/parameters/sca_exemptions'

module GenesisRuby
  module Api
    module Requests
      module Wpf
        # Web-Payment Form Request
        class Create < Request # rubocop:disable Metrics/ClassLength

          include Mixins::Requests::Financial::PaymentAttributes
          include Mixins::Requests::AddressInfoAttributes
          include Mixins::Requests::Financial::AsyncAttributes
          include Mixins::Requests::Financial::NotificationAttributes
          include Mixins::Requests::Financial::PendingPaymentAttributes
          include Mixins::Requests::Financial::Threeds::Version2::WpfAttributes
          include Mixins::Requests::Financial::Cards::AccountOwnerAttributes
          include Mixins::Requests::Financial::Cards::Recurring::RecurringCategoryAttributes
          include Mixins::Requests::Financial::DynamicDescriptorAttributes
          include Mixins::Requests::Financial::RiskAttributes
          include Mixins::Requests::Financial::Business::BusinessAttributes

          attr_reader   :locale, :sca_preference, :sca_exemption
          attr_accessor :transaction_id, :usage, :description, :consumer_id, :return_cancel_url, :remember_card,
                        :lifetime, :web_payment_form_id

          # The transaction types that the merchant is willing to accept payments for
          def add_transaction_type(name, custom_attributes = {})
            unless GenesisRuby::Utils::Transactions::WpfTypes.valid? name
              raise ParameterError, 'Invalid Transaction Type given.'
            end

            self.transaction_types = { transaction_type: {
              '@attributes': { name: name.to_s.downcase }, **custom_attributes
            } }
          end

          # Define ISO 639-1 language code to the URL
          def locale=(value)
            init_api_wpf_configuration(language: value.to_s.downcase)
          end

          # Signifies whether to perform SCA on the transaction. At least one 3DS transaction type has to be submitted.
          def sca_preference=(value)
            allowed_options attribute:      __method__,
                            allowed:        [true, false],
                            value:          value,
                            allow_empty:    true,
                            error_message: 'Accepts only boolean values'
          end

          # Exemption for the Strong Customer Authentication. The allowed options are low_value, low_risk
          def sca_exemption=(value)
            sca_exemptions = GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions

            allowed_options attribute:   __method__,
                            allowed:     [sca_exemptions::LOW_VALUE, sca_exemptions::LOW_RISK],
                            value:       value.to_s.empty? ? nil : value.to_s.downcase,
                            allow_empty: true
          end

          protected

          # Load base configuration
          def init_configuration
            init_xml_configuration
            init_api_wpf_configuration
          end

          def init_required_fields
            self.required_fields = %i[
              transaction_id
              amount
              currency
              notification_url
              return_success_url
              return_failure_url
              return_cancel_url
              transaction_types
            ]
          end

          # Perform validation over the defined parameters upon request execution
          def check_requirements
            unless GenesisRuby::Api::Constants::Currencies::Iso4217.valid?(currency)
              raise ParameterError, "Invalid Currency given with value #{currency}"
            end

            super
          end

          # Define Web-Payment Form transaction request structure
          def populate_structure # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
            self.tree_structure = {
              wpf_payment: {
                transaction_id:            transaction_id,
                amount:                    transform_amount(amount, currency),
                currency:                  currency,
                usage:                     usage,
                description:               description,
                consumer_id:               consumer_id,
                customer_email:            customer_email,
                customer_phone:            customer_phone,
                notification_url:          notification_url,
                return_success_url:        return_success_url,
                return_failure_url:        return_failure_url,
                return_cancel_url:         return_cancel_url,
                return_pending_url:        return_pending_url,
                billing_address:           billing_address_parameters_structure,
                shipping_address:          shipping_address_parameters_structure,
                transaction_types:         transaction_types,
                business_attributes:       business_attributes_structure,
                remember_card:             remember_card,
                lifetime:                  lifetime,
                sca_preference:            sca_preference,
                sca_params:                {
                  sca_exemption: sca_exemption
                },
                threeds_v2_params:         threeds_v2_wpf_attributes_structure,
                web_payment_form_id:       web_payment_form_id,
                recurring_category:        recurring_category,
                dynamic_descriptor_params: dynamic_descriptor_structure,
                risk_params:               risk_parameters_structure,
                account_owner:             account_owner_attributes_structure
              }
            }
          end

          private

          attr_reader :transaction_types

          # Add every transaction type to the transaction types structure
          def transaction_types=(value)
            @transaction_types ||= []

            @transaction_types.push(value)
          end

        end
      end
    end
  end
end
