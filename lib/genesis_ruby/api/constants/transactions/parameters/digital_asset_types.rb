# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Digital Asset Types
          class DigitalAssetTypes

            extend Mixins::Constants::Common

            # Default crypto flag
            CRYPTO = 'crypto'

            # Central Bank Digital Currency or tokenized deposits
            CBDC = 'cbdc'

            # Stablecoin (Fiat-backed)
            STABLECOIN = 'stablecoin'

            # Blockchain native token/coin
            BLOCKCHAIN_NATIVE_TOKEN = 'blockchain_native_token'

            # Non-fungible token
            NFT = 'nft'

          end
        end
      end
    end
  end
end
