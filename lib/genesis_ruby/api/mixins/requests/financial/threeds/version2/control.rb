require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/control/device_types'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/control/challenge_window_sizes'
require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/control/challenge_indicators'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 Control
              module Control

                attr_reader :threeds_v2_control_device_type, :threeds_v2_control_challenge_window_size,
                            :threeds_v2_control_challenge_indicator

                # Identifies the device channel of the consumer
                def threeds_v2_control_device_type=(value)
                  allowed_types = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::
                      DeviceTypes.all

                  allowed_options attribute: __method__, allowed: allowed_types, value: value, allow_empty: true
                end

                # Identifies the size of the challenge window for the consumer
                def threeds_v2_control_challenge_window_size=(value)
                  allowed_sizes = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::
                      ChallengeWindowSizes.all

                  allowed_options attribute: __method__, allowed: allowed_sizes, value: value, allow_empty: true
                end

                # The value has weight and might impact the decision whether a challenge will be required for the
                # transaction or not
                def threeds_v2_control_challenge_indicator=(value)
                  allowed_indicators = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::
                      Control::ChallengeIndicators.all

                  allowed_options attribute: __method__, allowed: allowed_indicators, value: value, allow_empty: true
                end

                protected

                # Request Control Attributes structure
                def control_attributes
                  {
                    device_type:           threeds_v2_control_device_type,
                    challenge_window_size: threeds_v2_control_challenge_window_size,
                    challenge_indicator:   threeds_v2_control_challenge_indicator
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
