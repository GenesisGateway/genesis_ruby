# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CustomerIdentification
            # Specifies the type of the document ID.
            class CustomerIdentificationType

              extend Api::Mixins::Constants::Common

              # Document ID type - birthdate certificate
              BIRTH_DATE                  = 'birth_date'

              # Document ID type - unspecified
              UNSPECIFIED                 = 'unspecified'

              # Document ID type - national
              NATIONAL                    = 'national'

              # Document ID type - passport number
              PASSPORT_NUMBER             = 'passport_number'

              # Document ID type - driver license
              DRIVER_LICENSE              = 'driver_license'

              # Document ID type - tax
              TAX                         = 'tax'

              # Document ID type - company registration number
              COMPANY_REGISTRATION_NUMBER = 'company_registration_number'

              # Document ID type - proxy
              PROXY                       = 'proxy'

              # Document ID type - social security number
              SOCIAL_SECURITY_NUMBER      = 'social_security_number'

              # Document ID type - alien registration number
              ALIEN_REGISTRATION_NUMBER   = 'alien_registration_number'

              # Document ID type - law enforcement
              LAW_ENFORCEMENT             = 'law_enforcement'

              # Document ID type - military
              MILITARY                    = 'military'

              # Document ID type - travel
              TRAVEL                      = 'travel'

              # Document ID type - email
              EMAIL                       = 'email'

              # Document ID type - phone number
              PHONE_NUMBER                = 'phone_number'

            end
          end
        end
      end
    end
  end
end
