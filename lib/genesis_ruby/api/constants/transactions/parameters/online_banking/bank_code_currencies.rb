require 'genesis_ruby/api/constants/transactions/parameters/online_banking/bank_codes'

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module OnlineBanking
            # Bank Code Currencies allowed values
            class BankCodeCurrencies # rubocop:disable Metrics/ClassLength

              extend Mixins::Constants::Common

              CURRENCIES = {
                AUD: [
                  BankCodes::PID
                ],
                BRL: [
                  BankCodes::CA
                ],
                CAD: [
                  BankCodes::CPI
                ],
                CHF: [
                  BankCodes::PF
                ],
                CNY: [
                  BankCodes::ABC, BankCodes::BOB, BankCodes::BOC, BankCodes::BOCO, BankCodes::CCB, BankCodes::CCD,
                  BankCodes::CEB, BankCodes::CIB, BankCodes::CMB, BankCodes::CMBC, BankCodes::CITIC, BankCodes::ICBC,
                  BankCodes::GDB, BankCodes::HXB, BankCodes::PINGANBANK, BankCodes::PSBC, BankCodes::QUICKPAY,
                  BankCodes::SHB, BankCodes::SPABANK, BankCodes::SPDB, BankCodes::YLB
                ],
                CLP: [
                  BankCodes::SP
                ],
                EUR: [
                  BankCodes::PF, BankCodes::BCT, BankCodes::TRL
                ],
                THB: [
                  BankCodes::BBL_IB_U, BankCodes::KBANK_PAYPLUS, BankCodes::BAY_IB_U, BankCodes::KTB_IB_U,
                  BankCodes::SCB_IB_U
                ],
                USD: [
                  BankCodes::SN, BankCodes::IT, BankCodes::BR, BankCodes::BB, BankCodes::WP, BankCodes::BN,
                  BankCodes::PS, BankCodes::BO
                ],
                MYR: [
                  BankCodes::FPX_ABB, BankCodes::FPX_ABMB, BankCodes::FPX_AMB, BankCodes::FPX_BIMB, BankCodes::FPX_BMMB,
                  BankCodes::FPX_BKRM, BankCodes::FPX_BSN, BankCodes::FPX_CIMBCLICKS, BankCodes::FPX_HLB,
                  BankCodes::FPX_KFH, BankCodes::FPX_MB2U, BankCodes::FPX_OCBC, BankCodes::FPX_PBB, BankCodes::FPX_RHB,
                  BankCodes::FPX_SCB, BankCodes::FPX_UOB
                ],
                PEN: [
                  BankCodes::BC, BankCodes::IB, BankCodes::EF, BankCodes::BP
                ],
                PYG: [
                  BankCodes::PE
                ],
                IDR: [
                  BankCodes::DK_BCA_IB, BankCodes::DK_BRI_IB, BankCodes::DK_CIMBCLICKS_IB, BankCodes::DK_DANAMON_IB,
                  BankCodes::DK_PERMATANET_IB
                ],
                INR: [
                  BankCodes::ABPB, BankCodes::AIRP, BankCodes::ALLA, BankCodes::ANDB, BankCodes::BARB_R,
                  BankCodes::BBKM, BankCodes::BKDN, BankCodes::BKID, BankCodes::CBIN, BankCodes::CIUB, BankCodes::CNRB,
                  BankCodes::CORP, BankCodes::COSB, BankCodes::CSBK, BankCodes::DBSS, BankCodes::DCBL, BankCodes::DEUT,
                  BankCodes::DLXB, BankCodes::ESFB, BankCodes::FDRL, BankCodes::HDFC, BankCodes::IBKL, BankCodes::ICIC,
                  BankCodes::IDFB, BankCodes::IDIB, BankCodes::INDB, BankCodes::IOBA, BankCodes::JAKA, BankCodes::JSBP,
                  BankCodes::KARB, BankCodes::KKBK, BankCodes::KVBL, BankCodes::LAVB_C, BankCodes::LAVB_R,
                  BankCodes::MAHB, BankCodes::NKGS, BankCodes::ORBC, BankCodes::PMCB, BankCodes::PSIB,
                  BankCodes::PUNB_R, BankCodes::RATN, BankCodes::SBBJ, BankCodes::SBHY, BankCodes::SBIN,
                  BankCodes::SBMY, BankCodes::SBTR, BankCodes::SCBL, BankCodes::SIBL, BankCodes::SRCB, BankCodes::STBP,
                  BankCodes::SVCB, BankCodes::SYNB, BankCodes::TMBL, BankCodes::TNSC, BankCodes::UBIN, BankCodes::UCBA,
                  BankCodes::UTBI, BankCodes::UTIB, BankCodes::VIJB, BankCodes::YESB
                ],
                MXN: [
                  BankCodes::SE, BankCodes::BQ
                ],
                PHP: [
                  BankCodes::DRAGONPAY
                ],
                SGD: [
                  BankCodes::DBS, BankCodes::UOB, BankCodes::OCBC, BankCodes::SCB
                ],
                UYU: [
                  BankCodes::AI
                ],
                VND: [
                  BankCodes::VTCP_VPBANK, BankCodes::VTCP_ABBANK, BankCodes::VTCP_ACB, BankCodes::VTCP_AGRIBANK,
                  BankCodes::VTCP_BACABANK, BankCodes::VTCP_BIDV, BankCodes::VTCP_BVB, BankCodes::VTCP_DONGABANK,
                  BankCodes::VTCP_EXIMBANK, BankCodes::VTCP_GPBANK, BankCodes::VTCP_HDBANK, BankCodes::VTCP_LVPB,
                  BankCodes::VTCP_MB, BankCodes::VTCP_MARITIMEBANK, BankCodes::VTCP_NAMABANK, BankCodes::VTCP_NAVIBANK,
                  BankCodes::VTCP_OCEANBANK, BankCodes::VTCP_PGBANK, BankCodes::VTCP_PHUONGDONG, BankCodes::VTCP_SHB,
                  BankCodes::VTCP_SACOMBANK, BankCodes::VTCP_SAIGONBANK, BankCodes::VTCP_SEAABANK,
                  BankCodes::VTCP_TECHCOMBANK, BankCodes::VTCP_TIENPHONGBANK, BankCodes::VTCP_VIB,
                  BankCodes::VTCP_VIETABANK, BankCodes::VTCP_VIETCOMBANK, BankCodes::VTCP_VIETINBANK
                ],
                PLN: [
                  BankCodes::BLK
                ],
                GBP: [
                  BankCodes::TRL
                ]
              }.freeze

              class << self

                # Return All available allowed values
                def all
                  CURRENCIES.keys.map { |currency| currency.to_s.downcase }
                end

                # Retrieve the allowed bank codes for the provided currency
                def bank_codes_per_currency(currency)
                  return CURRENCIES[currency.to_s.upcase.to_sym] if CURRENCIES.key? currency.to_s.upcase.to_sym

                  []
                end

              end

            end
          end
        end
      end
    end
  end
end
