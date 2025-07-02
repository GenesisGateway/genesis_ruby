# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Constants
        module ModuleConstantsStub

          extend GenesisRuby::Api::Mixins::Constants::Common

          CONSTANT_1 = 'constant_1'
          CONSTANT_2 = 'constant_2'

        end
      end
    end
  end
end
