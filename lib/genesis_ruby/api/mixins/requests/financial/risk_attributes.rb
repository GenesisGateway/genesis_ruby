# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Risk Params Attributes
          module RiskAttributes

            attr_accessor :risk_ssn, :risk_mac_address, :risk_session_id, :risk_user_id, :risk_user_level, :risk_email,
                          :risk_phone, :risk_remote_ip, :risk_serial_number, :risk_pan_tail, :risk_bin,
                          :risk_first_name, :risk_last_name, :risk_country, :risk_pan, :risk_forwarded_ip,
                          :risk_username, :risk_password, :risk_bin_name, :risk_bin_phone

            protected

            # Risk Params Structure
            def risk_parameters_structure # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
              {
                ssn:           risk_ssn,
                mac_address:   risk_mac_address,
                session_id:    risk_session_id,
                user_id:       risk_user_id,
                user_level:    risk_user_level,
                email:         risk_email,
                phone:         risk_phone,
                remote_ip:     risk_remote_ip,
                serial_number: risk_serial_number,
                pan_tail:      risk_pan_tail,
                bin:           risk_bin,
                first_name:    risk_first_name,
                last_name:     risk_last_name,
                country:       risk_country,
                pan:           risk_pan,
                forwarded_ip:  risk_forwarded_ip,
                username:      risk_username,
                password:      risk_password,
                bin_name:      risk_bin_name,
                bin_phone:     risk_bin_phone
              }
            end

          end
        end
      end
    end
  end
end
