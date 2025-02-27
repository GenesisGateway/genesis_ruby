require 'genesis_ruby/api/constants/transactions/parameters/credential_on_files'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Credential On File shared attributes mixin
            module CredentialOnFileAttributes

              attr_accessor :credential_on_file

              protected

              # Credential on file allowed field values validations
              def credential_on_file_field_validations
                {
                  credential_on_file: Api::Constants::Transactions::Parameters::CredentialOnFiles.all
                }
              end

            end
          end
        end
      end
    end
  end
end
