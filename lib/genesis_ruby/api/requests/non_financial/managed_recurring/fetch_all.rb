# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module ManagedRecurring
          # Retrieves all active managed recurring items.
          class FetchAll < Base::Versioned

            # FetchAll initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'managed_recurring/items'
            end

            protected

            # Override default Versioned Network configuration
            def init_configuration
              super

              init_get_configuration
            end

            # FetchAll request structure
            def request_structure
              {}
            end

          end
        end
      end
    end
  end
end
