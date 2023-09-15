require 'genesis_ruby/api/mixins/requests/customer_address/billing_info_attributes'
require 'genesis_ruby/api/mixins/requests/customer_address/shipping_info_attributes'
require 'genesis_ruby/api/mixins/requests/customer_address/customer_info_attributes'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Mixin Address Info Attributes
        module AddressInfoAttributes

          include CustomerAddress::BillingInfoAttributes
          include CustomerAddress::ShippingInfoAttributes
          include CustomerAddress::CustomerInfoAttributes

        end
      end
    end
  end
end
