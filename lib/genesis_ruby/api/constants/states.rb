module GenesisRuby
  module Api
    module Constants
      # Genesis Response States
      module States

        extend Mixins::Constants::Common

        # Transaction was approved by the schemes and is successful.
        APPROVED            = 'approved'.freeze

        # Transaction was declined by the schemes or risk management.
        DECLINED            = 'declined'.freeze

        # The outcome of the transaction could not be determined, e.g. at a timeout situation.
        # Transaction state will eventually change, so make a reconcile after a certain time frame.
        PENDING             = 'pending'.freeze

        # An asynchronous transaction (3-D secure payment) has been initiated and is waiting for user
        # input.
        # Updates of this state will be sent to the notification url specified in request.
        PENDING_ASYNC       = 'pending_async'.freeze

        # Transaction is in-progress
        IN_PROGRESS         = 'in_progress'.freeze

        # Once an approved transaction is refunded the state changes to refunded.
        REFUNDED            = 'refunded'.freeze

        # Transaction was authorized, but later the merchant canceled it.
        VOIDED              = 'voided'.freeze

        # An error has occurred while negotiating with the schemes.
        ERROR               = 'error'.freeze

        # Transaction failed, but it was not declined
        UNSUCCESSFUL        = 'unsuccessful'.freeze

        # WPF initial status
        NEW                 = 'new'.freeze

        # WPF in-progress status
        USER                = 'user'.freeze

        # WPF timeout has occurred
        TIMEOUT             = 'timeout'.freeze

        # Once an approved transaction is chargeback the state changes to change- backed.
        #
        # Chargeback is the state of rejecting an accepted transaction (with funds transferred)
        # by the cardholder or the issuer
        CHARGEBACKED        = 'chargebacked'.freeze

        # Once a chargebacked transaction is charged, the state changes to charge- back reversed.
        #
        # Chargeback has been canceled.
        CHARGEBACK_REVERSED = 'chargeback_reversed'.freeze

        # Once a chargeback reversed transaction is chargebacked the state changes to pre arbitrated.
        PRE_ARBITRATED      = 'pre_arbitrated'.freeze

        # Status of the consumer from Consumer API
        ENABLED             = 'enabled'.freeze

        # Status of the consumer from Consumer API
        DISABLED            = 'disabled'.freeze

        # Transaction API success status
        SUCCESS             = 'success'.freeze

        # WPF status represent submitted form
        SUBMITTED           = 'submitted'.freeze

        # An asynchronous transaction has been finalized by user but is waiting final update from provider.
        PENDING_HOLD        = 'pending_hold'.freeze

        # Once a chargeback_reversed/represented transaction is chargebacked the state changes to second chargebacked.
        SECOND_CHARGEBACKED = 'second_chargebacked'.freeze

        # Once a chargebacked transaction is charged, the state changes to represented. Chargeback has been canceled.
        REPRESENTED         = 'represented'.freeze

      end
    end
  end
end
