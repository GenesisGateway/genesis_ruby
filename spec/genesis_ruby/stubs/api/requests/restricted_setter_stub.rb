module GenesisSpec
  module Stubs
    module Api
      module Requests
        # Restricted Setter Sub
        class RestrictedSetterStub

          attr_accessor :attr_string, :attr_option, :attr_date, :attr_int, :attr_arr

          include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

        end
      end
    end
  end
end
