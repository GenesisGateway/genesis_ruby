module GenesisRuby
  module Api
    module Requests
      module Base
        module Financials
          # Base Class used for all transaction request containing Credit Card data
          class CreditCard < GenesisRuby::Api::Requests::Base::Financial

            include Mixins::Requests::Financial::Cards::AccountOwnerAttributes
            include Mixins::Requests::Financial::Cards::CredentialOnFileAttributes
            include Mixins::Requests::Financial::Cards::CreditCardAttributes
            include Mixins::Requests::Financial::Cards::TokenizationAttributes
            include Mixins::Requests::Financial::Cards::TokenizationParamsAttributes
            include Mixins::Requests::Financial::Cards::UcofAttributes

            attr_reader :scheme_tokenized

            # Visa tokenization for Visa
            # Digital Secure Remote Payments (DSRP) for Mastercard.
            def scheme_tokenized=(value)
              allowed_options attribute:      __method__,
                              allowed:        [true, false],
                              value:          value,
                              allow_empty:    true,
                              error_message: 'Accepts only boolean values'
            end

            protected

            # Request Field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency]
              field_values.merge! credential_on_file_field_validations
            end

            # Credit Card attributes
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              credit_card_attributes_structure.merge(
                tokenization_attributes_structure,
                {
                  account_owner:                             account_owner_attributes_structure,
                  credential_on_file:                        credential_on_file,
                  credential_on_file_transaction_identifier: credential_on_file_transaction_identifier,
                  credential_on_file_settlement_date:        credential_on_file_settlement_date,
                  scheme_tokenized:                          scheme_tokenized,
                  tokenization_params:                       tokenization_params_attributes_structure
                }
              )
            end

          end
        end
      end
    end
  end
end
