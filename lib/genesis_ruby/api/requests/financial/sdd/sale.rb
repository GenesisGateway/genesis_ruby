module GenesisRuby
  module Api
    module Requests
      module Financial
        module Sdd
          # Sepa Direct Debit Payment, popular in Germany.
          class Sale < Requests::Base::Financial

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::BankAttributes
            include Api::Mixins::Requests::Financial::PaymentAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes
            include Api::Mixins::Requests::Financial::DynamicDescriptorAttributes

            attr_accessor :company_name, :mandate_reference

            protected

            # SDD Sale transaction type
            def transaction_type
              Api::Constants::Transactions::SDD_SALE
            end

            # SDD field validation
            def init_field_validations
              super

              required_fields.push *%i[
                transaction_id usage amount currency iban billing_first_name billing_last_name billing_country
              ]

              field_values.merge! currency:        Api::Constants::Currencies::Iso4217.all.map(&:upcase),
                                  billing_country: %w(AT BE CY EE FI FR DE GR IE IT LV LT LU MT MC NL PT SK SM SI ES)
            end

            # SDD Sale request structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              payment_attributes_structure.merge(
                {
                  iban:                      iban,
                  bic:                       bic,
                  company_name:              company_name,
                  mandate_reference:         mandate_reference,
                  return_success_url:        return_success_url,
                  return_failure_url:        return_failure_url,
                  return_pending_url:        return_pending_url,
                  billing_address:           billing_address_parameters_structure,
                  shipping_address:          shipping_address_parameters_structure,
                  dynamic_descriptor_params: dynamic_descriptor_structure
                }
              )
            end

          end
        end
      end
    end
  end
end
