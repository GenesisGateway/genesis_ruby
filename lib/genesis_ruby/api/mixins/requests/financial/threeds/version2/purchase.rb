require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/purchase/categories'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 Purchase
              module Purchase

                attr_reader :threeds_v2_purchase_category

                # Identifies the type of transaction being authenticated
                def threeds_v2_purchase_category=(value)
                  allowed_indicators = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::
                      Purchase::Categories.all

                  allowed_options attribute:   __method__,
                                  allowed:     allowed_indicators,
                                  value:       value.to_s,
                                  allow_empty: true
                end

                protected

                # Request Purchase Attributes structure
                def purchase_attributes
                  {
                    category: threeds_v2_purchase_category
                  }
                end

              end
            end
          end
        end
      end
    end
  end
end
