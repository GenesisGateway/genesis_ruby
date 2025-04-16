module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module OnlineBankingPayments
            # Payer attributes
            module PayerAttributes

              attr_reader :payer_document_id, :payer_bank_code, :payer_bank_account_number,
                          :payer_bank_branch, :payer_bank_account_verification_digit,
                          :payer_bank_phone_number

              # Payer document ID
              def payer_document_id=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 16
              end

              # The bank code used to process the transaction
              def payer_bank_code=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 12
              end

              # The payer's bank account number
              def payer_bank_account_number=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 33
              end

              # The name of the bank branch where the account is held
              def payer_bank_branch=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 11
              end

              # Single digit verification code assigned by the external provider,
              # used to validate the bank account
              def payer_bank_account_verification_digit=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 1
              end

              # The payer's bank contact phone number
              def payer_bank_phone_number=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 11
              end

              protected

              # Payer parameters structure
              def payer_parameters_structure
                {
                  document_id:                     payer_document_id,
                  bank_code:                       payer_bank_code,
                  bank_account_number:             payer_bank_account_number,
                  bank_branch:                     payer_bank_branch,
                  bank_account_verification_digit: payer_bank_account_verification_digit,
                  bank_phone_number:               payer_bank_phone_number
                }
              end

            end
          end
        end
      end
    end
  end
end
