module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Consumers
          # Retrieves consumer details based on consumer id or email
          class Retrieve < Base::Consumer

            attr_accessor :email, :consumer_id

            # Retrieve Consumer constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'retrieve_consumer'
            end

            protected

            # Retrieve Consumer custom field validations
            def check_requirements
              raise ParameterError, 'Either email or consumer_id field has to be set.' if email.nil? && consumer_id.nil?

              super
            end

            # Retrieve Consumer request structure
            def request_structure
              {
                email:       email,
                consumer_id: consumer_id
              }
            end

          end
        end
      end
    end
  end
end
