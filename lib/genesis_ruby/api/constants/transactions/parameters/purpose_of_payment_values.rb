# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Human-readable Purpose of Payment values (Visa)
          class PurposeOfPaymentValues

            extend Mixins::Constants::Common

            # Account management
            ACCOUNT_MANAGEMENT = 'account_management'

            # Air transport related business
            AIR_TRANSPORT_RELATED_BUSINESS = 'air_transport_related_business'

            # Transaction is the payment of allowance
            PAYMENT_OF_ALLOWANCE = 'payment_of_allowance'

            # Settlement of annuity
            SETTLEMENT_OF_ANNUITY = 'settlement_of_annuity'

            # Unemployment disability benefit
            UNEMPLOYMENT_DISABILITY_BENEFIT = 'unemployment_disability_benefit'

            # Business expenses
            BUSINESS_EXPENSES = 'business_expenses'

            # Bonus payment
            BONUS_PAYMENT = 'bonus_payment'

            # Bus transport related business
            BUS_TRANSPORT_RELATED_BUSINESS = 'bus_transport_related_business'

            # Cash management transfer
            CASH_MANAGEMENT_TRANSFER = 'cash_management_transfer'

            # Payment of cable TV bill
            PAYMENT_OF_CABLE_TV_BILL = 'payment_of_cable_tv_bill'

            # Government institute issued related to cash compensation, helplessness, disability
            GOVERNMENT_INSTITUTE_ISSUED_RELATED_TO_CASH_COMPENSATION_HELPLESSNESS_DISABILITY =
              'government_institute_issued_related_to_cash_compensation_helplessness_disability'

            # Credit card payment
            CREDIT_CARD_PAYMENT = 'credit_card_payment'

            # Payment of credit card bill
            PAYMENT_OF_CREDIT_CARD_BILL = 'payment_of_credit_card_bill'

            # Payment for charity reasons
            PAYMENT_FOR_CHARITY_REASONS = 'payment_for_charity_reasons'

            # Collection payment
            COLLECTION_PAYMENT = 'collection_payment'

            # Commercial payment
            COMMERCIAL_PAYMENT = 'commercial_payment'

            # Commission
            COMMISSION = 'commission'

            # Compensation relating to interest loss/value date adjustment and can include fees
            COMPENSATION_RELATING_TO_INTEREST_LOSS_VALUE_DATE_ADJUSTMENT_AND_CAN_INCLUDE_FEES =
              'compensation_relating_to_interest_loss_value_date_adjustment_and_can_include_fees'

            # Payment of copyright
            PAYMENT_OF_COPYRIGHT = 'payment_of_copyright'

            # Related to a debit card payment
            RELATED_TO_DEBIT_CARD_PAYMENT = 'related_to_debit_card_payment'

            # Payment of a deposit
            PAYMENT_OF_DEPOSIT = 'payment_of_deposit'

            # Payment of dividend
            PAYMENT_OF_DIVIDEND = 'payment_of_dividend'

            # Payment of study/tuition fees
            PAYMENT_OF_STUDY_TUITION_FEES = 'payment_of_study_tuition_fees'

            # Education
            EDUCATION = 'education'

            # Payment of electricity bill
            PAYMENT_OF_ELECTRICITY_BILL = 'payment_of_electricity_bill'

            # Energies
            ENERGIES = 'energies'

            # General fees
            GENERAL_FEES = 'general_fees'

            # Payment for ferry related business
            PAYMENT_FOR_FERRY_RELATED_BUSINESS = 'payment_for_ferry_related_business'

            # Foreign exchange
            FOREIGN_EXCHANGE = 'foreign_exchange'

            # Payment of gas bill
            PAYMENT_OF_GAS_BILL = 'payment_of_gas_bill'

            # Compensation to unemployed persons during insolvency procedures
            COMPENSATION_TO_UNEMPLOYED_PERSONS_DURING_INSOLVENCY_PROCEDURES =
              'compensation_to_unemployed_persons_during_insolvency_procedures'

            # Government payment
            GOVERNMENT_PAYMENT = 'government_payment'

            # Health insurance
            HEALTH_INSURANCE = 'health_insurance'

            # Reimbursement of credit card payment
            REIMBURSEMENT_OF_CREDIT_CARD_PAYMENT = 'reimbursement_of_credit_card_payment'

            # Reimbursement of debit card payment
            REIMBURSEMENT_OF_DEBIT_CARD_PAYMENT = 'reimbursement_of_debit_card_payment'

            # Payment of car insurance premium
            PAYMENT_OF_CAR_INSURANCE_PREMIUM = 'payment_of_car_insurance_premium'

            # Transaction is related to the payment of an insurance claim
            TRANSACTION_RELATED_TO_PAYMENT_OF_INSURANCE_CLAIM = 'transaction_related_to_payment_of_insurance_claim'

            # Installment
            INSTALLMENT = 'installment'

            # Insurance premium
            INSURANCE_PREMIUM = 'insurance_premium'

            # Payment of mutual funds, investment products and shares
            PAYMENT_OF_MUTUAL_FUNDS_INVESTMENT_PRODUCTS_AND_SHARES =
              'payment_of_mutual_funds_investment_products_and_shares'

            # Intra company payment
            INTRA_COMPANY_PAYMENT = 'intra_company_payment'

            # Interest
            INTEREST = 'interest'

            # Income tax
            INCOME_TAX = 'income_tax'

            # Investment
            INVESTMENT = 'investment'

            # Labor insurance
            LABOR_INSURANCE = 'labor_insurance'

            # License fee
            LICENSE_FEE = 'license_fee'

            # Life insurance
            LIFE_INSURANCE = 'life_insurance'

            # Loan
            LOAN = 'loan'

            # Medical services
            MEDICAL_SERVICES = 'medical_services'

            # Mobile P2B payment
            MOBILE_P2B_PAYMENT = 'mobile_p2b_payment'

            # Mobile P2P payment
            MOBILE_P2P_PAYMENT = 'mobile_p2p_payment'

            # Mobile top up
            MOBILE_TOP_UP = 'mobile_top_up'

            # Not otherwise specified
            NOT_OTHERWISE_SPECIFIED = 'not_otherwise_specified'

            # Other
            OTHER = 'other'

            # Transaction is related to a payment of other telecom related bill
            TRANSACTION_RELATED_TO_PAYMENT_OF_OTHER_TELECOM_RELATED_BILL =
              'transaction_related_to_payment_of_other_telecom_related_bill'

            # Payroll
            PAYROLL = 'payroll'

            # Contribution to pension fund
            CONTRIBUTION_TO_PENSION_FUND = 'contribution_to_pension_fund'

            # Pension payment
            PENSION_PAYMENT = 'pension_payment'

            # Payment of telephone bill
            PAYMENT_OF_TELEPHONE_BILL = 'payment_of_telephone_bill'

            # Property insurance
            PROPERTY_INSURANCE = 'property_insurance'

            # Transaction is for general rental/lease
            TRANSACTION_FOR_GENERAL_RENTAL_LEASE = 'transaction_for_general_rental_lease'

            # The payment of rent
            THE_PAYMENT_OF_RENT = 'the_payment_of_rent'

            # Payment for railway transport related business
            PAYMENT_FOR_RAILWAY_TRANSPORT_RELATED_BUSINESS = 'payment_for_railway_transport_related_business'

            # Royalties
            ROYALTIES = 'royalties'

            # Salary payment
            SALARY_PAYMENT = 'salary_payment'

            # Payment to savings/retirement account
            PAYMENT_TO_SAVINGS_RETIREMENT_ACCOUNT = 'payment_to_savings_retirement_account'

            # Securities
            SECURITIES = 'securities'

            # Social security benefit
            SOCIAL_SECURITY_BENEFIT = 'social_security_benefit'

            # Study
            STUDY = 'study'

            # Subscription
            SUBSCRIPTION = 'subscription'

            # Supplier payment
            SUPPLIER_PAYMENT = 'supplier_payment'

            # Refund of a tax payment or obligation
            REFUND_OF_TAX_PAYMENT_OR_OBLIGATION = 'refund_of_tax_payment_or_obligation'

            # Tax payment
            TAX_PAYMENT = 'tax_payment'

            # Transaction is related to a payment of telecommunications related bill
            TRANSACTION_RELATED_TO_PAYMENT_OF_TELECOMMUNICATIONS_RELATED_BILL =
              'transaction_related_to_payment_of_telecommunications_related_bill'

            # Trade services operation
            TRADE_SERVICES_OPERATION = 'trade_services_operation'

            # Treasury payment
            TREASURY_PAYMENT = 'treasury_payment'

            # Payment for travel
            PAYMENT_FOR_TRAVEL = 'payment_for_travel'

            # Utility bill payment
            UTILITY_BILL_PAYMENT = 'utility_bill_payment'

            # Value added tax payment
            VALUE_ADDED_TAX_PAYMENT = 'value_added_tax_payment'

            # Withholding
            WITHHOLDING = 'withholding'

            # Payment of water bill
            PAYMENT_OF_WATER_BILL = 'payment_of_water_bill'

          end
        end
      end
    end
  end
end
