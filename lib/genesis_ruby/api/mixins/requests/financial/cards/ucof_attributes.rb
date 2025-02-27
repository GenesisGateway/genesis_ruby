module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # UCOF shared attributes mixin
            module UcofAttributes

              attr_reader :credential_on_file_transaction_identifier

              # UCOF Transaction Identifier
              def credential_on_file_transaction_identifier=(value)
                limited_string attribute: __method__, value: value.to_s, min: 15, max: 32
              end

              # UCOF Settlement Date
              def credential_on_file_settlement_date
                @credential_on_file_settlement_date&.strftime Api::Constants::DateTimeFormats::MM_DD
              end

              # UCOF Settlement Date
              def credential_on_file_settlement_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

            end
          end
        end
      end
    end
  end
end
