# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Account Owner Attributes mixin
            module AccountOwnerAttributes

              ACCOUNT_NAME_LENGTH = 35

              attr_reader :account_first_name, :account_middle_name, :account_last_name

              # Account owner's first name.
              def account_first_name=(value)
                account_accessor __method__, value
              end

              # Account owner's middle name.
              def account_middle_name=(value)
                account_accessor __method__, value
              end

              # Account owner's last name.
              def account_last_name=(value)
                account_accessor __method__, value
              end

              protected

              # Tokenization Attributes Structure
              def account_owner_attributes_structure
                {
                  first_name:  account_first_name,
                  middle_name: account_middle_name,
                  last_name:   account_last_name
                }
              end

              private

              # Account accessor common method
              def account_accessor(method, value)
                limited_string attribute: method, value: value.to_s, max: ACCOUNT_NAME_LENGTH
              end

            end
          end
        end
      end
    end
  end
end
