# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Alternatives
            module Alipay
              # Site Information Attributes Stub
              class SiteInformationAttributesStub

                include GenesisRuby::Api::Mixins::Requests::NonFinancial::Alternatives::Alipay::
                    SiteInformationAttributes
                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

                public :site_information_structure, :site_information_field_validations

              end
            end
          end
        end
      end
    end
  end
end
