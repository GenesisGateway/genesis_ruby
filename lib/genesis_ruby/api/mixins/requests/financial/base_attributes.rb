module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Base Financial Transaction Requests attributes
          module BaseAttributes

            attr_accessor :transaction_id, :usage, :remote_ip

          end
        end
      end
    end
  end
end
