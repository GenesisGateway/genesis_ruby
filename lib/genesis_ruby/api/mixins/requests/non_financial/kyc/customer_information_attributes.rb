# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/document_types'
require 'genesis_ruby/api/constants/non_financial/kyc/genders'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Customer Information Attributes mixin
            module CustomerInformationAttributes

              include Api::Mixins::Requests::BirthDateAttributes

              attr_accessor :first_name, :middle_name, :last_name, :customer_email,
                            :address1, :address2, :city, :zip_code, :country,
                            :province, :phone1, :phone2, :document_number, :document_type, :gender

              protected

              # Sets the request field validations
              def customer_information_required_fields
                %i[first_name last_name customer_email address1 city province zip_code country]
              end

              # Sets the request field values validations
              def customer_information_required_field_values
                {
                  gender:        Api::Constants::NonFinancial::Kyc::Genders.all,
                  document_type: Api::Constants::NonFinancial::Kyc::DocumentTypes.all
                }
              end

              # Returns the customer information structure as a hash
              def customer_information_structure # rubocop:disable Metrics/MethodLength
                {
                  first_name:      first_name,
                  middle_name:     middle_name,
                  last_name:       last_name,
                  customer_email:  customer_email,
                  address1:        address1,
                  address2:        address2,
                  city:            city,
                  province:        province,
                  zip_code:        zip_code,
                  country:         country,
                  phone1:          phone1,
                  phone2:          phone2,
                  birth_date:      birth_date,
                  document_type:   document_type,
                  document_number: document_number,
                  gender:          gender
                }
              end

            end
          end
        end
      end
    end
  end
end
