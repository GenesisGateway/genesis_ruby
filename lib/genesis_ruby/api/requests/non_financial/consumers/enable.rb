module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Consumers
          # Enable consumer that was disabled in the past.
          class Enable < Base::Consumer

            attr_accessor :email, :consumer_id

            # Enable Consumer constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'enable_consumer'
            end

            protected

            # Enable consumer field validations
            def init_field_validations
              super

              required_fields.push *%i[email consumer_id]
            end

            # Enable Consumer request structure
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
