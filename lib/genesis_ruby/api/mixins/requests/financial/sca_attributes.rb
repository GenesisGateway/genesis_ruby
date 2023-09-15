require 'genesis_ruby/api/constants/transactions/parameters/sca_exemptions'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # SCA Attributes mixin
          module ScaAttributes

            attr_reader :sca_exemption
            attr_accessor :sca_visa_merchant_id

            # The exemption that the transaction should take advantage of
            def sca_exemption=(value)
              allowed_options attribute:   __method__,
                              allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions.all,
                              value:       value.to_s.empty? ? nil : value.to_s.downcase,
                              allow_empty: true
            end

            protected

            # SCA Params Attributes Structure
            def sca_attributes_structure
              {
                exemption:        sca_exemption,
                visa_merchant_id: sca_visa_merchant_id
              }
            end

          end
        end
      end
    end
  end
end
