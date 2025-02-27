module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module OnlineBankingPayments
            # PIX shared attributes
            module PixAttributes

              attr_accessor :company_type, :company_activity, :mothers_name

              # Incorporation Date Accessor
              def incorporation_date
                @incorporation_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Incorporation Date Accessor
              def incorporation_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

            end
          end
        end
      end
    end
  end
end
