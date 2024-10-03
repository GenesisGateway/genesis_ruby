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

                attr_accessor :threeds_v2_control_device_type, :threeds_v2_control_challenge_window_size,
                              :threeds_v2_control_challenge_indicator

                protected

                # Control field validations structure
                def threeds_control_field_validations
                  {
                    threeds_v2_control_device_type:           Api::Constants::Transactions::Parameters::Threeds::
                        Version2::Control::DeviceTypes.all,
                    threeds_v2_control_challenge_window_size: Api::Constants::Transactions::Parameters::Threeds::
                        Version2::Control::ChallengeWindowSizes.all,
                    threeds_v2_control_challenge_indicator:   Api::Constants::Transactions::Parameters::Threeds::
                        Version2::Control::ChallengeIndicators.all
                  }
                end

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
