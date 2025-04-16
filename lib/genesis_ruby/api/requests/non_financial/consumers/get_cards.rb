module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Consumers
          # Get previously tokenized card details for a consumer.
          class GetCards < Base::Consumer

            attr_accessor :email, :consumer_id

            # GetCards Consumer constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'get_consumer_cards'
            end

            protected

            # GetCards consumer field validations
            def init_field_validations
              super

              required_fields.push *%i[email consumer_id]
            end

            # GetCards Consumer request structure
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
