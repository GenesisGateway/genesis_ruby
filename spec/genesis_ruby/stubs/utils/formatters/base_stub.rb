module GenesisSpec
  module Stubs
    module Utils
      module Formatters
        # Base Formatter Stub
        class BaseStub < GenesisRuby::Utils::Formatters::Base

          def formatting_keys
            %w(key3)
          end

          def required_keys
            %w(key1 key2)
          end

        end
      end
    end
  end
end
