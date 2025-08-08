# frozen_string_literal: true

require 'genesis_ruby/errors/parameter_error'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module CustomerAddress
          # Mixin CustomerInfoAttributes
          module CustomerInfoAttributes

            attr_reader   :customer_email
            attr_accessor :customer_phone

            # Email of the customer
            def customer_email=(value)
              parse_email attribute: __method__, value: value, allow_empty: true
            end

          end
        end
      end
    end
  end
end
