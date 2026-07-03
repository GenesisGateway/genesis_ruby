# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Dissociate Owners from a specific Owner.
            class DissociateOwners < Base::NonFinancial::Payee::Base

              attr_accessor :owner_unique_id

              # Dissociate Owners initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners/:owner_unique_id/owners'

                init_delete_configuration
              end

              # Add a unique_id to the collection of owners to dissociate
              def add_unique_id(value)
                raise GenesisRuby::InvalidArgumentError, 'Unique ID must be a String' unless value.is_a?(String)
                raise GenesisRuby::InvalidArgumentError, 'Unique ID is required' if value.empty?

                unique_ids << value
              end

              # Assign unique_ids collection with validation
              def unique_ids=(value)
                if value.nil?
                  @unique_ids = nil
                elsif !value.is_a?(Array)
                  raise GenesisRuby::InvalidArgumentError, 'Unique IDs must be an Array'
                else
                  validate_unique_ids_collection(value)
                  @unique_ids = value
                end
              end

              protected

              # Unique IDs collection
              def unique_ids
                @unique_ids ||= []
              end

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  owner_unique_id
                  unique_ids
                ]
              end

              # Returns the request structure
              def request_structure
                {
                  owners: {
                    unique_ids: unique_ids
                  }
                }
              end

              # Override API endpoint configuration
              def process_request_parameters
                super

                processed_path = request_path.dup.gsub(':owner_unique_id', owner_unique_id.to_s)

                init_api_service_configuration request_path: processed_path, include_token: false
              end

              private

              # Validate unique_ids collection entries
              def validate_unique_ids_collection(value)
                value.each_with_index do |uid, index|
                  unless uid.is_a?(String) && !uid.empty?
                    raise GenesisRuby::InvalidArgumentError,
                          "Unique ID at index #{index} must be a non-empty String"
                  end
                end
              end

            end
          end
        end
      end
    end
  end
end
