module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # African Mobile Attributes mixin
          module AfricanMobileAttributes

            attr_reader :target, :operator

            # Number of the Paybill for which the transaction is intended
            def target=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 20
            end

            # Name of the Mobile network operator which should process the transaction
            def operator=(value)
              allowed_options attribute: __method__,
                              allowed:
                                GenesisRuby::Api::Constants::Transactions::Parameters::AfricanMobileOperators.all,
                              value: value.to_s.upcase,
                              allow_empty: false
            end

          end
        end
      end
    end
  end
end
