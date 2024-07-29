module GenesisRuby
  module Utils
    module Transactions
      module TravelData
        module AirlineItinerary
          # Airline Itinerary Data base class
          class Base

            include Api::Mixins::Requests::RestrictedSetter

            # Constructor
            def initialize(params = {}) # rubocop:disable Style/OptionHash
              parse_attributes params if params.is_a? Hash

              super()
            end

            # Item attribute structure
            def attributes_structure; end

            protected

            # Initialize attributes
            def parse_attributes(params)
              params.each { |key, value| __send__ "#{key}=", value }
            end

          end
        end
      end
    end
  end
end
