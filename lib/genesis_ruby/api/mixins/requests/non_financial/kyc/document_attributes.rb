module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Document Attributes mixin
            module DocumentAttributes

              attr_accessor :proof, :full_address
              attr_reader   :first_name, :middle_name, :last_name

              # Gets date of birth for the document attributes
              def date_of_birth
                @date_of_birth&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                )
              end

              # Sets date of birth for the document attributes
              def date_of_birth=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Sets the first name for the document attributes
              def first_name=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 32
              end

              # Sets the middle name for the document attributes
              def middle_name=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 32
              end

              # Sets the last name for the document attributes
              def last_name=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 32
              end

              protected

              # Defines the structure of the document attributes
              def document_attributes_structure
                {
                  proof:         proof,
                  date_of_birth: date_of_birth,
                  first_name:    first_name,
                  middle_name:   middle_name,
                  last_name:     last_name,
                  full_address:  full_address
                }
              end

            end
          end
        end
      end
    end
  end
end
