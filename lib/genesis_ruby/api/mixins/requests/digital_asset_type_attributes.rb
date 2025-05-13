require 'genesis_ruby/api/constants/transactions/parameters/digital_asset_types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Digital Asset Type Attributes mixin
        module DigitalAssetTypeAttributes

          attr_reader :digital_asset_type

          # When performing crypto currency transaction with a VISA card there is an option
          # to specify the digital asset type for detailed identification of the current crypto
          # currency transaction
          def digital_asset_type=(value)
            allowed_options attribute:   __method__,
                            allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::DigitalAssetTypes.all,
                            value:       value,
                            allow_empty: true
          end

        end
      end
    end
  end
end
