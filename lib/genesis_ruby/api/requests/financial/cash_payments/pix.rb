require 'genesis_ruby/api/constants/transactions/parameters/cash_payments/genders'
require 'genesis_ruby/api/constants/transactions/parameters/cash_payments/marital_statuses'
require 'genesis_ruby/api/constants/transactions/parameters/cash_payments/company_types'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Pix is a payment service, which represents a new way of receiving/sending money.
          # Pix allows payments to be made instantly.
          class Pix < Requests::Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::BirthDateAttributes
            include Api::Mixins::Requests::DocumentAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::OnlineBankingPayments::PixAttributes
            include Api::Mixins::Requests::Financial::PaymentAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            attr_accessor :gender, :marital_status, :sender_occupation, :nationality, :country_of_origin, :birth_city,
                          :birth_state

            # Billing Country custom accessor
            def billing_country
              return nil unless @billing_country

              @billing_country.to_s.upcase
            end

            # Override incorpocation date with specific format for Pix request
            def incorporation_date
              @incorporation_date&.strftime Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
            end

            protected

            # Pix transaction type
            def transaction_type
              Api::Constants::Transactions::PIX
            end

            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency document_id]

              field_values.merge! currency:        Api::Constants::Currencies::Iso4217.all.map(&:upcase),
                                  billing_country: %w(BR),
                                  gender:          Api::Constants::Transactions::Parameters::CashPayments::Genders.all,
                                  marital_status:  Api::Constants::Transactions::Parameters::CashPayments::
                                      MaritalStatuses.all,
                                  company_type:    Api::Constants::Transactions::Parameters::CashPayments::
                                      CompanyTypes.all
            end

            # PayPal request attributes structure
            def payment_transaction_structure # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
              payment_attributes_structure.merge(
                {
                  return_success_url: return_success_url,
                  return_failure_url: return_failure_url,
                  return_pending_url: return_pending_url,
                  customer_email:     customer_email,
                  document_id:        document_id,
                  billing_address:    billing_address_parameters_structure,
                  shipping_address:   shipping_address_parameters_structure,
                  birth_date:         birth_date,
                  gender:             gender,
                  marital_status:     marital_status,
                  sender_occupation:  sender_occupation,
                  nationality:        nationality,
                  country_of_origin:  country_of_origin,
                  company_type:       company_type,
                  company_activity:   company_activity,
                  incorporation_date: incorporation_date,
                  mothers_name:       mothers_name
                }
              )
            end

          end
        end
      end
    end
  end
end
