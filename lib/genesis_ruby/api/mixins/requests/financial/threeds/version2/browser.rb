require 'genesis_ruby/api/constants/transactions/parameters/threeds/version2/browser/color_depths'
require 'genesis_ruby/errors/invalid_argument_error'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 Browser Attributes
              module Browser

                attr_reader :threeds_v2_browser_accept_header, :threeds_v2_browser_java_enabled,
                            :threeds_v2_browser_language, :threeds_v2_browser_color_depth,
                            :threeds_v2_browser_screen_height, :threeds_v2_browser_screen_width,
                            :threeds_v2_browser_time_zone_offset, :threeds_v2_browser_user_agent

                # Exact content of the HTTP accept headers as sent to the 3DS Requester from the Cardholder browser
                def threeds_v2_browser_accept_header=(value)
                  limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 2048
                end

                # Value representing the browser language as defined in IETF BCP47
                def threeds_v2_browser_language=(value)
                  limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 8
                end

                # Value representing the bit depth of the colour palette for displaying images, in bits per pixel
                def threeds_v2_browser_color_depth=(value)
                  allowed_depths = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::
                      Browser::ColorDepths.all

                  allowed_options attribute:   __method__,
                                  allowed:     allowed_depths,
                                  value:       value.to_s.empty? ? nil : value.to_i,
                                  allow_empty: true
                end

                # Total height of the Cardholder's screen in pixels
                def threeds_v2_browser_screen_height=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Total width of the Cardholder's screen in pixels
                def threeds_v2_browser_screen_width=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Boolean that represents the ability of the cardholder browser to execute Java
                def threeds_v2_browser_java_enabled=(value)
                  allowed_options attribute:     __method__,
                                  allowed:       [true, false],
                                  value:         value,
                                  allow_empty:   true,
                                  error_message: 'Accepts only boolean values'
                end

                # Time difference between UTC time and the Cardholder browser local time, in minutes
                def threeds_v2_browser_time_zone_offset=(value)
                  limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 5
                end

                # Exact content of the HTTP user-agent header
                def threeds_v2_browser_user_agent=(value)
                  limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 2048
                end

                protected

                # Request Browser Attributes structure
                def browser_attributes
                  {
                    accept_header:    threeds_v2_browser_accept_header,
                    java_enabled:     threeds_v2_browser_java_enabled,
                    language:         threeds_v2_browser_language,
                    color_depth:      threeds_v2_browser_color_depth,
                    screen_height:    threeds_v2_browser_screen_height,
                    screen_width:     threeds_v2_browser_screen_width,
                    time_zone_offset: threeds_v2_browser_time_zone_offset,
                    user_agent:       threeds_v2_browser_user_agent
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
