require 'digest'

module GenesisRuby
  module Utils
    module Threeds
      # Threeds V2 Utils
      class V2

        class << self

          # Generate 3DSV2 signature
          def generate_signature(unique_id:, amount:, timestamp:, merchant_password:)
            Digest::SHA512.hexdigest "#{unique_id}#{amount}#{timestamp}#{merchant_password}"
          end

        end

      end
    end
  end
end
