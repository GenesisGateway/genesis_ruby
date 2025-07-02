# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Base
        # Consumers API base request class
        class Consumer < Versioned

          def initialize(configuration, builder_interface = Builder::XML)
            super configuration, builder_interface
          end

          protected

          def populate_structure
            super

            @tree_structure = Hash["#{request_path}_request", request_structure]
          end

        end
      end
    end
  end
end
