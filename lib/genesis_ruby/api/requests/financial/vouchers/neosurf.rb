# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Vouchers
          # Neosurf is a prepaid card (voucher) that is used for online shopping
          class Neosurf < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes

            attr_reader :voucher_number

            # Voucher number. Alphanumeric maximum 10 characters
            def voucher_number=(value)
              limited_string attribute: __method__,
                             value: value.to_s.empty? ? nil : value.to_s,
                             min: 1,
                             max: 10
            end

            protected

            # Neosurf transaction type
            def transaction_type
              Api::Constants::Transactions::NEOSURF
            end

            # Neosurf Field Validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency billing_country]
              field_values.merge! currency:        %w( AUD BGN BRL CAD CHF CNY CZK DKK EUR GBP HKD HUF IDR
                                                      ILS INR JPY KRW MXN MYR NOK NZD PHP PLN RON RUB SEK
                                                      SGD THB TRY USD XOF ZAR ),
                                  billing_country: %w( AT DZ AU BI BF BJ BE CV CY CA CF TD CO CG CM CD DK GQ
                                                    FR GM DE GA GN GH GW HK IE IT CI KE LU MW MZ MA MR ML
                                                    NE NG NL NZ NO PL PT RW RU RO SE ES SL SN ST CH RS TR
                                                    TG TN GB TZ UG ZW ZM )
            end

            # Neosurf request structure
            def payment_transaction_structure
              {
                voucher_number:     voucher_number,
                customer_email:     customer_email,
                customer_phone:     customer_phone,
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                billing_address:    billing_address_parameters_structure,
                shipping_address:   shipping_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
