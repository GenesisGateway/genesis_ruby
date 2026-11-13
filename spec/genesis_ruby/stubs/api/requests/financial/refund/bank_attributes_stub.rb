# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Refund
            # Refund Bank Attributes Stub
            class BankAttributesStub

              include GenesisRuby::Api::Mixins::Requests::Financial::Refund::BankAttributes
              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

              public :refund_bank_attributes_structure, :refund_bank_attributes_field_validations

            end
          end
        end
      end
    end
  end
end
