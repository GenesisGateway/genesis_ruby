module GenesisRuby
  module Api
    module Requests
      module Base
        # Base Versioned Request class used for Non Financial JSON API services
        class Versioned < Request

          DEFAULT_VERSION = 'v1'.freeze
          private_constant :DEFAULT_VERSION

          attr_reader :version, :allowed_versions

          # Base Versioned Request constructor
          def initialize(configuration, builder_interface = Builder::JSON)
            super configuration, builder_interface

            self.allowed_versions = [DEFAULT_VERSION]
            self.version          = DEFAULT_VERSION
            self.request_path     = ''
          end

          # Defines the version for the request
          def version=(value)
            allowed_options(
              attribute:     __method__,
              value:         value,
              allowed:       allowed_versions,
              allow_empty:   false,
              error_message: 'Invalid API version! '
            )

            init_configuration
          end

          protected

          attr_reader :request_path

          # Every Specific request defines available versions
          def allowed_versions=(value)
            raise InvalidArgumentError, 'Allowed versions accepts only Array values' unless value.is_a? Array

            @allowed_versions = value
          end

          # Defines the endpoint of the request
          def request_path=(value)
            @request_path = value.to_s

            init_configuration

            @request_path
          rescue BuilderError
            @request_path = ''

            raise InvalidArgumentError, 'The Request can not be configured!'
          end

          # Initialize Request configuration
          def init_configuration
            super

            case @builder_interface
            when Builder::XML then init_xml_configuration
            when Builder::JSON then init_json_configuration
            else raise BuilderError, "Invalid Builder Interface specified for #{self.class.name}"
            end

            init_api_gateway_configuration request_path: "#{version}/#{request_path}", include_token: false
          end

          # Request structure. Overridden for common structure parameters
          def populate_structure
            super

            @tree_structure = request_structure
          end

          # Request structure
          def request_structure
            raise NoMethodError, 'Request structure must be defined!'
          end

        end
      end
    end
  end
end
