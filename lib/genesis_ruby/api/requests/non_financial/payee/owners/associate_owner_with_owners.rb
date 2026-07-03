# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Associate Owners with a specific Owner.
            class AssociateOwnerWithOwners < Base::NonFinancial::Payee::Base

              attr_accessor :owner_unique_id

              # Associate Owner With Owners initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners/:owner_unique_id/owners'
              end

              # Add a single owner to the owners collection
              def add_owner(unique_id:, **options)
                unless unique_id.is_a?(String)
                  raise GenesisRuby::InvalidArgumentError, 'Owner unique_id must be a String'
                end
                raise GenesisRuby::InvalidArgumentError, 'Owner unique_id is required' if unique_id.empty?

                validate_percent_ownership(options[:percent_ownership]) if options.key?(:percent_ownership)

                owners << { unique_id: unique_id }.merge(options)
              end

              # Assign owners collection with validation
              def owners=(value)
                if value.nil?
                  @owners = nil
                elsif !value.is_a?(Array)
                  raise GenesisRuby::InvalidArgumentError, 'Owners must be an Array'
                else
                  validate_owners_collection(value)
                  @owners = value
                end
              end

              protected

              # Owners collection
              def owners
                @owners ||= []
              end

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  owner_unique_id
                  owners
                ]
              end

              private

              # Validate the owners collection entries
              def validate_owners_collection(value)
                value.each_with_index do |owner, index|
                  unless owner.is_a?(Hash) && owner[:unique_id].is_a?(String) && !owner[:unique_id].empty?
                    raise GenesisRuby::InvalidArgumentError,
                          "Owner at index #{index} must be a Hash with a non-empty String unique_id"
                  end

                  validate_percent_ownership(owner[:percent_ownership]) if owner.key?(:percent_ownership)
                end
              end

              # Validate percent_ownership value when provided
              def validate_percent_ownership(value)
                return if value.nil?

                raise GenesisRuby::InvalidArgumentError, 'percent_ownership must be numeric' unless value.is_a?(Numeric)

                return if value >= 0.0 && value <= 100.0

                raise GenesisRuby::InvalidArgumentError, 'percent_ownership must be between 0.0 and 100.0'
              end

              # Returns the request structure
              def request_structure
                {
                  owners: owners
                }
              end

              # Override API endpoint configuration
              def process_request_parameters
                super

                processed_path = request_path.dup.gsub(':owner_unique_id', owner_unique_id.to_s)

                init_api_service_configuration request_path: processed_path, include_token: false
              end

            end
          end
        end
      end
    end
  end
end
