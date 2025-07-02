# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Consumers
          # Updates consumer email and addresses.
          class Update < Base::Consumer

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes

            attr_accessor :email, :consumer_id

            # Update Consumer constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'update_consumer'
            end

            protected

            # Update Consumer field validations
            def init_field_validations
              super

              required_fields.push *%i[email consumer_id]
            end

            # Update Consumer request structure
            def request_structure
              {
                email:            email,
                consumer_id:      consumer_id,
                billing_address:  billing_address_parameters_structure,
                shipping_address: shipping_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
