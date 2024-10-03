require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/merchant_risk/shipping_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/merchant_risk/delivery_timeframes'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/merchant_risk/reorder_item_indicators'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/merchant_risk/pre_order_purchase_indicators' # rubocop: disable Layout/LineLength

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 MerchantRisk
              module MerchantRisk

                attr_reader :threeds_v2_merchant_risk_gift_card_count
                attr_accessor :threeds_v2_merchant_risk_shipping_indicator,
                              :threeds_v2_merchant_risk_delivery_timeframe,
                              :threeds_v2_merchant_risk_reorder_items_indicator,
                              :threeds_v2_merchant_risk_pre_order_purchase_indicator,
                              :threeds_v2_merchant_risk_gift_card

                # For a pre-ordered purchase, the expected date that the merchandise will be available
                def threeds_v2_merchant_risk_pre_order_date
                  @threeds_v2_merchant_risk_pre_order_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # For a pre-ordered purchase, the expected date that the merchandise will be available
                def threeds_v2_merchant_risk_pre_order_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # For prepaid or gift card purchase, total count of individual prepaid or gift cards/codes purchased
                def threeds_v2_merchant_risk_gift_card_count=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                protected

                # Merchant Risk field validations structure
                def threeds_merchant_risk_field_validations # rubocop:disable Metrics/MethodLength
                  {
                    threeds_v2_merchant_risk_shipping_indicator:           Api::Constants::Transactions::Parameters::
                        Threeds::Version2::MerchantRisk::ShippingIndicators.all,
                    threeds_v2_merchant_risk_delivery_timeframe:           Api::Constants::Transactions::Parameters::
                        Threeds::Version2::MerchantRisk::DeliveryTimeframes.all,
                    threeds_v2_merchant_risk_reorder_items_indicator:      Api::Constants::Transactions::Parameters::
                        Threeds::Version2::MerchantRisk::ReorderItemIndicators.all,
                    threeds_v2_merchant_risk_pre_order_purchase_indicator: Api::Constants::Transactions::Parameters::
                        Threeds::Version2::MerchantRisk::PreOrderPurchaseIndicators.all,
                    threeds_v2_merchant_risk_gift_card:                    [true, false]
                  }
                end

                # Request Merchant Risk Attributes structure
                def merchant_risk_attributes
                  {
                    shipping_indicator:           threeds_v2_merchant_risk_shipping_indicator,
                    delivery_timeframe:           threeds_v2_merchant_risk_delivery_timeframe,
                    reorder_items_indicator:      threeds_v2_merchant_risk_reorder_items_indicator,
                    pre_order_purchase_indicator: threeds_v2_merchant_risk_pre_order_purchase_indicator,
                    pre_order_date:               threeds_v2_merchant_risk_pre_order_date,
                    gift_card:                    threeds_v2_merchant_risk_gift_card,
                    gift_card_count:              threeds_v2_merchant_risk_gift_card_count
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
