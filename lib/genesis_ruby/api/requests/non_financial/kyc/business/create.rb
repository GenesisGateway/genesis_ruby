# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Business
            # Create a Business record
            class Create < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :registration_number, :country, :name

              # Initializes the Create Business Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'businesses'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[registration_number country]
              end

              # Returns the request structure for the Create Business request
              def request_structure
                {
                  registration_number: registration_number,
                  country:             country,
                  name:                name
                }
              end

            end
          end
        end
      end
    end
  end
end
