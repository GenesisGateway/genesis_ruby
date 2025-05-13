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
              BIRTH_DATE                  = 'birth_date'.freeze

              # Document ID type - unspecified
              UNSPECIFIED                 = 'unspecified'.freeze

              # Document ID type - national
              NATIONAL                    = 'national'.freeze

              # Document ID type - passport number
              PASSPORT_NUMBER             = 'passport_number'.freeze

              # Document ID type - driver license
              DRIVER_LICENSE              = 'driver_license'.freeze

              # Document ID type - tax
              TAX                         = 'tax'.freeze

              # Document ID type - company registration number
              COMPANY_REGISTRATION_NUMBER = 'company_registration_number'.freeze

              # Document ID type - proxy
              PROXY                       = 'proxy'.freeze

              # Document ID type - social security number
              SOCIAL_SECURITY_NUMBER      = 'social_security_number'.freeze

              # Document ID type - alien registration number
              ALIEN_REGISTRATION_NUMBER   = 'alien_registration_number'.freeze

              # Document ID type - law enforcement
              LAW_ENFORCEMENT             = 'law_enforcement'.freeze

              # Document ID type - military
              MILITARY                    = 'military'.freeze

              # Document ID type - travel
              TRAVEL                      = 'travel'.freeze

              # Document ID type - email
              EMAIL                       = 'email'.freeze

              # Document ID type - phone number
              PHONE_NUMBER                = 'phone_number'.freeze

            end
          end
        end
      end
    end
  end
end
