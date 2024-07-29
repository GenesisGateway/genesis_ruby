require 'genesis_ruby/api/requests/base/financials/credit_card'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Sale transactions combine authorize and capture into one step
          class Sale < Requests::Base::Financials::CreditCard

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::DocumentAttributes
            include Mixins::Requests::Financial::Business::BusinessAttributes
            include Mixins::Requests::Financial::Cards::FxRateAttributes
            include Mixins::Requests::Financial::Cards::Recurring::ManagedRecurringAttributes
            include Mixins::Requests::Financial::Cards::Recurring::RecurringCategoryAttributes
            include Mixins::Requests::Financial::Cards::Recurring::RecurringTypeAttributes
            include Mixins::Requests::Financial::CryptoAttributes
            include Mixins::Requests::Financial::DynamicDescriptorAttributes
            include Mixins::Requests::Financial::GamingAttributes
            include Mixins::Requests::Financial::MotoAttributes
            include Mixins::Requests::Financial::ReferenceAttributes
            include Mixins::Requests::Financial::RiskAttributes
            include Mixins::Requests::Financial::ScaAttributes
            include Mixins::Requests::Financial::TravelData::TravelAttributes

            protected

            # Sale Transaction Type
            def transaction_type
              GenesisRuby::Api::Constants::Transactions::SALE
            end

            def init_required_fields
              return super unless recurring_type == Constants::Transactions::Parameters::Recurring::Types::SUBSEQUENT

              self.required_fields = recurring_type_subsequent_required_request_attributes
            end

            def payment_transaction_structure # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
              super.merge(
                gaming:                    gaming,
                moto:                      moto,
                crypto:                    crypto,
                customer_email:            customer_email,
                customer_phone:            customer_phone,
                reference_id:              reference_id,
                document_id:               document_id,
                fx_rate_id:                fx_rate_id,
                billing_address:           billing_address_parameters_structure,
                shipping_address:          shipping_address_parameters_structure,
                risk_params:               risk_parameters_structure,
                dynamic_descriptor_params: dynamic_descriptor_structure,
                business_attributes:       business_attributes_structure,
                recurring_type:            recurring_type,
                recurring_category:        recurring_category,
                sca_params:                sca_attributes_structure,
                managed_recurring:         managed_recurring_attributes_structure,
                travel:                    travel_data_attributes_structure
              )
            end

          end
        end
      end
    end
  end
end
