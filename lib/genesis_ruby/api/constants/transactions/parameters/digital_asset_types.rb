module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Digital Asset Types
          class DigitalAssetTypes

            extend Mixins::Constants::Common

            # Default crypto flag
            CRYPTO = 'crypto'.freeze

            # Central Bank Digital Currency or tokenized deposits
            CBDC = 'cbdc'.freeze

            # Stablecoin (Fiat-backed)
            STABLECOIN = 'stablecoin'.freeze

            # Blockchain native token/coin
            BLOCKCHAIN_NATIVE_TOKEN = 'blockchain_native_token'.freeze

            # Non-fungible token
            NFT = 'nft'.freeze

          end
        end
      end
    end
  end
end
