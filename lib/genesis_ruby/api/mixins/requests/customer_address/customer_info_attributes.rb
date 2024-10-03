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
              raise GenesisRuby::ParameterError unless value.nil? || value =~ /\A.+@.+\..+\Z/

              @customer_email = value
            end

          end
        end
      end
    end
  end
end
