module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Consumer Identifier Attributes
          module ConsumerIdentifierAttributes

            attr_reader :consumer_reference, :national_id

            # Consumer reference is a unique consumer identifier
            def consumer_reference=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 20
            end

            # National Id of the consumer
            def national_id=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 20
            end

          end
        end
      end
    end
  end
end
