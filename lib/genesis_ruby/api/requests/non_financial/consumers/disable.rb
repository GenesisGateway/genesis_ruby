# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Consumers
          # Disable consumer from usage until further action.
          class Disable < Base::Consumer

            attr_accessor :email, :consumer_id

            # Disable Consumer constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'disable_consumer'
            end

            protected

            # Disable consumer field validations
            def init_field_validations
              super

              required_fields.push *%i[email consumer_id]
            end

            # Disable Consumer request structure
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
