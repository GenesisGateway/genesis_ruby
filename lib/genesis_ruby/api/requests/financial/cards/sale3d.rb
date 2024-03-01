require 'genesis_ruby/api/requests/base/financials/credit_card'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Sale3D combines a Sale transaction request by adding asynchronous processing
          class Sale3d < Requests::Base::Financials::CreditCard

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::DocumentAttributes
            include Mixins::Requests::Financial::AsyncAttributes
            include Mixins::Requests::Financial::Business::BusinessAttributes
            include Mixins::Requests::Financial::Cards::FxRateAttributes
            include Mixins::Requests::Financial::Cards::MpiAttributes
            include Mixins::Requests::Financial::Cards::Recurring::ManagedRecurringAttributes
            include Mixins::Requests::Financial::Cards::Recurring::RecurringCategoryAttributes
            include Mixins::Requests::Financial::Cards::Recurring::RecurringTypeAttributes
            include Mixins::Requests::Financial::CryptoAttributes
            include Mixins::Requests::Financial::DynamicDescriptorAttributes
            include Mixins::Requests::Financial::GamingAttributes
            include Mixins::Requests::Financial::MotoAttributes
            include Mixins::Requests::Financial::NotificationAttributes
            include Mixins::Requests::Financial::RiskAttributes
            include Mixins::Requests::Financial::ScaAttributes
            include Mixins::Requests::Financial::Threeds::Version2::CommonAttributes

            # Specifies the recurring type of transaction
            def recurring_type=(value)
              allowed_values = [
                GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL,
                GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::MANAGED
              ]

              allowed_options attribute: __method__, allowed: allowed_values, value: value, allow_empty: true
            end

            protected

            # Sale 3D Transaction Type
            def transaction_type
              GenesisRuby::Api::Constants::Transactions::SALE_3D
            end

            # Sale 3D transaction request parameters
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
              super.merge(
                notification_url:          notification_url,
                return_success_url:        return_success_url,
                return_failure_url:        return_failure_url,
                gaming:                    gaming,
                moto:                      moto,
                crypto:                    crypto,
                customer_email:            customer_email,
                customer_phone:            customer_phone,
                document_id:               document_id,
                fx_rate_id:                fx_rate_id,
                billing_address:           billing_address_parameters_structure,
                shipping_address:          shipping_address_parameters_structure,
                mpi_params:                mpi_attributes_structure,
                risk_params:               risk_parameters_structure,
                dynamic_descriptor_params: dynamic_descriptor_structure,
                business_attributes:       business_attributes_structure,
                recurring_type:            recurring_type,
                recurring_category:        recurring_category,
                sca_params:                sca_attributes_structure,
                threeds_v2_params:         threeds_v2_common_attributes_structure,
                managed_recurring:         managed_recurring_attributes_structure
              )
            end

          end
        end
      end
    end
  end
end
