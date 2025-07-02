# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module States
        # Genesis Response Status definitions
        class State

          # Helper method for defining available dynamic methods
          def self.handle_respond_to_states(symbol)
            name = symbol.to_s.downcase

            name.slice!('?') == '?' && GenesisRuby::Api::Constants::States.valid?(name)
          end

          attr_accessor :state

          def initialize(state)
            @state = state
          end

          # States dynamic methods. Must be valid Genesis Transaction State
          # Ex. new?, approved?
          def method_missing(symbol, *args)
            name = symbol.to_s.upcase

            super unless GenesisRuby::Api::Constants::States::State.handle_respond_to_states(name)

            name.chomp! '?'

            GenesisRuby::Api::Constants::States.valid?(name) &&
              state == GenesisRuby::Api::Constants::States.const_get(name)
          end

          # Respond to missing implementation
          def respond_to_missing?(symbol, include_private = false)
            GenesisRuby::Api::Constants::States::State.handle_respond_to_states(symbol) || super
          end

        end
      end
    end
  end
end
