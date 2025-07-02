# frozen_string_literal: true

require 'genesis_ruby/utils/transactions/travel_data/airline_itinerary/base'
require 'genesis_ruby/utils/money_format'

module GenesisRuby
  module Utils
    module Transactions
      module TravelData
        module AirlineItinerary
          # Signify a single AirlineItinerary Tax data
          class Tax < Base

            attr_reader :fee_type
            attr_accessor :fee_amount, :currency

            # Fee type
            def fee_type=(value)
              limited_string attribute: __method__, value: value, max: 8
            end

            # Get Single Tax structure
            def attributes_structure
              {
                fee_amount: parse_fee_amount,
                fee_type:   fee_type
              }
            end

            protected

            # Minor currency conversion if currency is set
            def parse_fee_amount
              return fee_amount if currency.nil? || fee_amount.nil?

              MoneyFormat.amount_to_exponent fee_amount, currency
            end

          end
        end
      end
    end
  end
end
