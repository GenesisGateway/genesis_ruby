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
              ONLINE_BANKING = 'online_banking'.freeze

              # Payment Type QR Payment
              QR_PAYMENT     = 'qr_payment'.freeze

              # Payment Type Quick Payment
              QUICK_PAYMENT  = 'quick_payment'.freeze

              # Payment Type Netbankig
              NETBANKING     = 'netbanking'.freeze

              # Payment Alipay QR
              ALIPAY_QR      = 'alipay_qr'.freeze

              # Payment Scotia Bank
              SCOTIABANK     = 'scotiabank'.freeze

              # Payment SPEI
              SPEI           = 'spei'.freeze

            end
          end
        end
      end
    end
  end
end
