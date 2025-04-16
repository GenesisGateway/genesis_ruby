module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # The beneficiary parameters attributes
          module BeneficiaryAttributes

            attr_accessor :beneficiary_name
            attr_reader   :beneficiary_document_id, :beneficiary_pix_key

            # The Document ID of the beneficiary, such as CPF or CNPJ for Brazilian entities
            def beneficiary_document_id=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 14
            end

            # The PIX key associated with the beneficiary
            def beneficiary_pix_key=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 36
            end

            protected

            # Beneficiary parameters structure
            def beneficiary_parameters_structure
              {
                name:        beneficiary_name,
                document_id: beneficiary_document_id,
                pix_key:     beneficiary_pix_key
              }
            end

          end
        end
      end
    end
  end
end
