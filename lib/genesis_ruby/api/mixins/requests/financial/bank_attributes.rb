# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Bank Attributes mixin
          module BankAttributes

            attr_reader :bic, :iban

            # BIC parameter validation
            def bic=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, min: 8, max: 11
            end

            # IBAN parameter validation
            def iban=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 34
            end

          end
        end
      end
    end
  end
end
