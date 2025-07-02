# frozen_string_literal: true

require 'genesis_ruby/utils/common'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 Mehtod
              module Method

                attr_reader :threeds_v2_method_callback_url

                # 3DS-Method related parameters for any callbacks and notifications
                def threeds_v2_method_callback_url=(value)
                  @threeds_v2_method_callback_url = nil

                  return if value.to_s.empty?

                  unless GenesisRuby::Utils::Common.valid_url?(value)
                    raise InvalidArgumentError, "Invalid URL given for #{__method__}"
                  end

                  @threeds_v2_method_callback_url = value
                end

                protected

                # Request Method Attributes structure
                def method_attributes
                  {
                    callback_url: threeds_v2_method_callback_url
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
