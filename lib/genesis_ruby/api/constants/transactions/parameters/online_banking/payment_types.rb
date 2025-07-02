# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module OnlineBanking
            # Payment Types allowed values
            class PaymentTypes

              extend Api::Mixins::Constants::Common

              # Payment Type Online Banking
              ONLINE_BANKING = 'online_banking'

              # Payment Type QR Payment
              QR_PAYMENT     = 'qr_payment'

              # Payment Type Quick Payment
              QUICK_PAYMENT  = 'quick_payment'

              # Payment Type Netbankig
              NETBANKING     = 'netbanking'

              # Payment Alipay QR
              ALIPAY_QR      = 'alipay_qr'

              # Payment Scotia Bank
              SCOTIABANK     = 'scotiabank'

              # Payment SPEI
              SPEI           = 'spei'

            end
          end
        end
      end
    end
  end
end
