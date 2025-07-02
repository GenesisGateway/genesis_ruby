# frozen_string_literal: true

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

                attr_accessor :threeds_v2_purchase_category

                protected

                # Purchase field validations structure
                def threeds_purchase_field_validations
                  {
                    threeds_v2_purchase_category: Api::Constants::Transactions::Parameters::Threeds::Version2::
                        Purchase::Categories.all
                  }
                end

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
