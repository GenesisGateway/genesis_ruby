module GenesisRuby
  module Api
    module Requests
      module Base
        # Base class for GraphQL API services
        class Graphql < Versioned

          # GraphQL base class constructor
          def initialize(configuration, builder_interface = Builder::GRAPHQL)
            super configuration, builder_interface

            @root_key     = 'query'
            @request_name = ''
          end

          protected

          attr_accessor :request_name, :root_key

          # Init GraphQL configuration
          def init_configuration
            init_graphql_configuration

            init_authorization_token

            init_api_service_configuration request_path: "#{request_path}/#{version}/graphql", include_token: false
          end

          # Every Request must load the proper token in the Request API Config
          def init_authorization_token
            raise NoMethodError, "Authorization token isn't defined for #{self.class.name}"
          end

          # Response Filters
          def query_filters
            raise NoMethodError, "Response Filters isn't defined for #{self.class.name}"
          end

          # Response Fields
          def query_response_fields
            raise NoMethodError, "Response Fields isn't defined for #{self.class.name}"
          end

          # GraphQL request structure
          def request_structure
            Hash[
              root_key,
              Hash[
                :action, request_name,
                :filters, query_filters,
                :response_fields, query_response_fields
              ]
            ]
          end

        end
      end
    end
  end
end
