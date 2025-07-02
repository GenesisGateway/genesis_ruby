# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          # Mode Attributes mixin
          module ModeAttributes

            attr_reader :mode

            # Mode
            def mode=(value)
              allowed_options attribute: __method__,
                              allowed: %w(list),
                              value: value.to_s.downcase,
                              allow_empty: true
            end

          end
        end
      end
    end
  end
end
