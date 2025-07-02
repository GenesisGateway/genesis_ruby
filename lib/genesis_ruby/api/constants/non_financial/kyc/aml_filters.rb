# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # Anti-money laundering filters
          class AmlFilters

            extend Mixins::Constants::Common

            SANCTION                              = 'sanction'
            WARNING                               = 'warning'
            FITNESS_PROBITY                       = 'fitness-probity'
            PEP                                   = 'pep'
            PEP_CLASS_1                           = 'pep-class-1'
            PEP_CLASS_2                           = 'pep-class-2'
            PEP_CLASS_3                           = 'pep-class-3'
            PEP_CLASS_4                           = 'pep-class-4'
            ADVERSE_MEDIA                         = 'adverse-media'
            ADVERSE_MEDIA_GENERAL                 = 'adverse-media-general'
            ADVERSE_MEDIA_NARCOTICS               = 'adverse-media-narcotics'
            ADVERSE_MEDIA_FRAUD                   = 'adverse-media-fraud'
            ADVERSE_MEDIA_TERRORISM               = 'adverse-media-terrorism'
            ADVERSE_MEDIA_SEXUAL_CRIME            = 'adverse-media-sexual-crime'
            ADVERSE_MEDIA_VIOLENT_CRIME           = 'adverse-media-violent-crime'
            ADVERSE_MEDIA_FINANCIAL_CRIME         = 'adverse-media-financial-crime'
            ADVERSE_MEDIA_V2_OTHER_MINOR          = 'adverse-media-v2-other-minor'
            ADVERSE_MEDIA_V2_OTHER_SERIOUS        = 'adverse-media-v2-other-serious'
            ADVERSE_MEDIA_V2_OTHER_FINANCIAL      = 'adverse-media-v2-other-financial'
            ADVERSE_MEDIA_V2_VIOLENCE_NON_AML_CFT = 'adverse-media-v2-violence-non-aml-cft'
            ADVERSE_MEDIA_V2_FINANCIAL_DIFFICULTY = 'adverse-media-v2-financial-difficulty'
            ADVERSE_MEDIA_V2_REGULATORY           = 'adverse-media-v2-regulatory'
            ADVERSE_MEDIA_V2_GENERAL_AML_CFT      = 'adverse-media-v2-general-aml-cft'
            ADVERSE_MEDIA_V2_CYBERCRIME           = 'adverse-media-v2-cybercrime'
            ADVERSE_MEDIA_V2_TERRORISM            = 'adverse-media-v2-terrorism'
            ADVERSE_MEDIA_V2_VIOLENCE_AML_CFT     = 'adverse-media-v2-violence-aml-cft'
            ADVERSE_MEDIA_V2_NARCOTICS_AML_CFT    = 'adverse-media-v2-narcotics-aml-cft'
            ADVERSE_MEDIA_V2_FRAUD_LINKED         = 'adverse-media-v2-fraud-linked'
            ADVERSE_MEDIA_V2_FINANCIAL_AML_CFT    = 'adverse-media-v2-financial-aml-cft'
            ADVERSE_MEDIA_V2_PROPERTY             = 'adverse-media-v2-property'

          end
        end
      end
    end
  end
end
