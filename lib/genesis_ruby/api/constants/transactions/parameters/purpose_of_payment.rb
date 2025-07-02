# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Purpose of Payment
          class PurposeOfPayment

            extend Mixins::Constants::Common

            # Interest
            ISINTE = 'ISINTE'

            # Income tax
            ISINTX = 'ISINTX'

            # Investment
            ISINVS = 'ISINVS'

            # Labor insurance
            ISLBRI = 'ISLBRI'

            # License fee
            ISLICF = 'ISLICF'

            # Life insurance
            ISLIFI = 'ISLIFI'

            # Loan
            ISLOAN = 'ISLOAN'

            # Medical services
            ISMDCS = 'ISMDCS'

            # Mobile P2B payment
            ISMP2B = 'ISMP2B'

            # Mobile P2P payment
            ISMP2P = 'ISMP2P'

            # Mobile top up
            ISMTUP = 'ISMTUP'

            # Not otherwise specified
            ISNOWS = 'ISNOWS'

            # Other
            ISOTHR = 'ISOTHR'

            # Transaction is related to a payment of other telecom related bill
            ISOTLC = 'ISOTLC'

            # Payroll
            ISPAYR = 'ISPAYR'

            # Contribution to pension fund
            ISPEFC = 'ISPEFC'

            # Pension payment
            ISPENS = 'ISPENS'

            # Payment of telephone bill
            ISPHON = 'ISPHON'

            # Property insurance
            ISPPTI = 'ISPPTI'

            # Transaction is for general rental/lease
            ISRELG = 'ISRELG'

            # The payment of rent
            ISRENT = 'ISRENT'

            # Payment for railway transport related business
            ISRLWY = 'ISRLWY'

            # Royalties
            ISROYA = 'ISROYA'

            # Salary payment
            ISSALA = 'ISSALA'

            # Payment to savings/retirement account
            ISSAVG = 'ISSAVG'

            # Securities
            ISSECU = 'ISSECU'

            # Social security benefit
            ISSSBE = 'ISSSBE'

            # Study
            ISSTDY = 'ISSTDY'

            # Subscription
            ISSUBS = 'ISSUBS'

            # Supplier payment
            ISSUPP = 'ISSUPP'

            # Refund of a tax payment or obligation
            ISTAXR = 'ISTAXR'

            # Tax payment
            ISTAXS = 'ISTAXS'

            # Transaction is related to a payment of telecommunications related bill
            ISTBIL = 'ISTBIL'

            # Trade services operation
            ISTRAD = 'ISTRAD'

            # Treasury payment
            ISTREA = 'ISTREA'

            # Payment for travel
            ISTRPT = 'ISTRPT'

            # Utility bill payment
            ISUBIL = 'ISUBIL'

            # Value added tax payment
            ISVATX = 'ISVATX'

            # With holding
            ISWHLD = 'ISWHLD'

            # Payment of water bill
            ISWTER = 'ISWTER'

          end
        end
      end
    end
  end
end
