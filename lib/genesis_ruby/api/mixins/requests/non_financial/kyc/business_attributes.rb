# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Business-related AML screening attributes
            module BusinessAttributes

              attr_accessor :business_name

              # Date of incorporation of the business
              def business_incorporation_date
                @business_incorporation_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                )
              end

              # Date of incorporation of the business
              def business_incorporation_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Defines the structure of the business attributes
              def business_attributes_structure
                {
                  name:               business_name,
                  incorporation_date: business_incorporation_date
                }
              end

            end
          end
        end
      end
    end
  end
end
