require 'genesis_ruby/api/constants/transactions/parameters/online_banking/payment_types'
require 'genesis_ruby/api/constants/transactions/parameters/online_banking/bank_code_currencies'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          module OnlineBanking
            # Online Banking PayIn transaction class
            class PayIn < Base::Financial # rubocop:disable Metrics/ClassLength

              include Api::Mixins::Requests::AddressInfoAttributes
              include Api::Mixins::Requests::DocumentAttributes
              include Api::Mixins::Requests::Financial::AsyncAttributes
              include Api::Mixins::Requests::Financial::OnlineBankingPayments::VirtualPaymentAddressAttributes
              include Api::Mixins::Requests::Financial::PaymentAttributes

              attr_accessor :user_category, :payment_type, :bank_code, :consumer_reference, :auth_code

              protected

              # Online Banking PayIn transaction type
              def transaction_type
                Api::Constants::Transactions::ONLINE_BANKING_PAYIN
              end

              # Online Banking PayIn field validations
              def init_field_validations # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
                required_fields.push *%i[transaction_id return_success_url return_failure_url amount currency bank_code]

                field_values.merge! payment_type: Api::Constants::Transactions::Parameters::OnlineBanking::
                                        PaymentTypes.all,
                                    currency:     Api::Constants::Transactions::Parameters::OnlineBanking::
                                        BankCodeCurrencies.all.map(&:upcase),
                                    bank_code:    Api::Constants::Transactions::Parameters::OnlineBanking::BankCodes.all

                field_value_dependencies.merge!(
                  {
                    currency: {
                      AUD: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('AUD')
                      },
                      BRL: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('BRL')
                      },
                      CAD: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('CAD')
                      },
                      CHF: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('CHF')
                      },
                      CNY: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('CNY')
                      },
                      CLP: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('CLP')
                      },
                      EUR: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('EUR')
                      },
                      THB: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('THB')
                      },
                      USD: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('USD')
                      },
                      MYR: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('MYR')
                      },
                      PEN: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('PEN')
                      },
                      PYG: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('PYG')
                      },
                      IDR: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('IDR')
                      },
                      INR: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('INR')
                      },
                      MXN: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('MXN')
                      },
                      PHP: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('PHP')
                      },
                      SGD: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('SGD')
                      },
                      UYU: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('UYU')
                      },
                      VND: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('VND')
                      },
                      PLN: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('PLN')
                      },
                      GBP: {
                        bank_code: Api::Constants::Transactions::Parameters::OnlineBanking::BankCodeCurrencies
                                     .bank_codes_per_currency('GBP')
                      }
                    }
                  }
                )
              end

              # Online Banking PayIn parameters structure
              def payment_transaction_structure # rubocop:disable Metrics/MethodLength
                payment_attributes_structure.merge(
                  {
                    return_success_url:      return_success_url,
                    return_failure_url:      return_failure_url,
                    billing_address:         billing_address_parameters_structure,
                    shipping_address:        shipping_address_parameters_structure,
                    customer_email:          customer_email,
                    customer_phone:          customer_phone,
                    payment_type:            payment_type,
                    bank_code:               bank_code,
                    document_id:             document_id,
                    user_category:           user_category,
                    virtual_payment_address: virtual_payment_address,
                    consumer_reference:      consumer_reference,
                    auth_code:               auth_code
                  }
                )
              end

            end
          end
        end
      end
    end
  end
end
