# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/scopes'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          # Scope Attributes mixin
          module ScopeAttributes

            attr_reader :scope

            # Scope
            def scope=(value)
              allowed_options attribute:   __method__,
                              allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::
                                Scopes.all,
                              value:       value,
                              allow_empty: true
            end

          end
        end
      end
    end
  end
end
