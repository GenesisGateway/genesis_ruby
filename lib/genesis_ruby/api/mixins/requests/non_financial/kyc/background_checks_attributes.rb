# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/aml_filters'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Anti-money laundering background check
            module BackgroundChecksAttributes

              attr_accessor :background_checks_first_name, :background_checks_middle_name,
                            :background_checks_last_name, :background_checks_full_name, :background_checks_match_score
              attr_reader   :background_checks_async_update

              # Customer's date of birth
              def background_checks_date_of_birth
                @background_checks_date_of_birth&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                )
              end

              # Customer's date of birth
              def background_checks_date_of_birth=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Will allow the system to send notifications with information
              # about the checked person when the status has been changed
              def background_checks_async_update=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # One or more AML Filters to query
              def background_checks_filters
                @background_checks_filters || []
              end

              # One or more AML Filters to query
              def background_checks_filters=(value)
                parse_array_of_strings attribute:   __method__,
                                       value:       value,
                                       allowed:     Api::Constants::NonFinancial::Kyc::AmlFilters.all,
                                       allow_empty: true
              end

              protected

              # Defines the structure of the background checks attributes
              def background_checks_attributes_structure
                {
                  first_name:    background_checks_first_name,
                  middle_name:   background_checks_middle_name,
                  last_name:     background_checks_last_name,
                  full_name:     background_checks_full_name,
                  date_of_birth: background_checks_date_of_birth,
                  async_update:  background_checks_async_update,
                  filters:       background_checks_filters,
                  match_score:   background_checks_match_score
                }
              end

            end
          end
        end
      end
    end
  end
end
