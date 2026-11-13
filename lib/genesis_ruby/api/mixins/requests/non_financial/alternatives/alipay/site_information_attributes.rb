# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/alternatives/alipay/site_types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Alternatives
            module Alipay
              # Alipay site information (site_information JSON object) attributes
              module SiteInformationAttributes

                attr_accessor :site_information_type
                attr_reader :site_information_url, :site_information_name

                # Website URL or app download URL, absolute http/https URL
                def site_information_url=(value)
                  parse_url attribute: __method__, value: value, allow_empty: true
                end

                # Website name or app name, max 512 characters
                def site_information_name=(value)
                  if value.to_s.empty?
                    assign_instance_variable __method__, nil
                  else
                    limited_string attribute: __method__, value: value.to_s, max: 512
                  end
                end

                protected

                # Site information allowed values
                def site_information_field_validations
                  {
                    site_information_type: Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes.all
                  }
                end

                # Site information structure
                def site_information_structure
                  {
                    type: site_information_type,
                    url:  site_information_url,
                    name: site_information_name
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
