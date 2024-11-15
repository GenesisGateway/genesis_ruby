module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module OnlineBanking
            # Bank Codes allowed values
            class BankCodes # rubocop:disable Metrics/ClassLength

              extend Api::Mixins::Constants::Common

              # Aditya Birla Idea Payments Bank
              ABPB = 'ABPB'.freeze

              # Airtel Payments Bank
              AIRP = 'AIRP'.freeze

              # Allahabad Bank
              ALLA = 'ALLA'.freeze

              # Andhra Bank
              ANDB = 'ANDB'.freeze

              # Bank of Baroda - Retail Banking
              BARB_R = 'BARB_R'.freeze

              # Bank of Bahrein and Kuwait
              BBKM = 'BBKM'.freeze

              # Dena Bank
              BKDN = 'BKDN'.freeze

              # Bank of India
              BKID = 'BKID'.freeze

              # Central Bank of India
              CBIN = 'CBIN'.freeze

              # City Union Bank
              CIUB = 'CIUB'.freeze

              # Canara Bank
              CNRB = 'CNRB'.freeze

              # Corporation Bank
              CORP = 'CORP'.freeze

              # Cosmos Co-operative Bank
              COSB = 'COSB'.freeze

              # Catholic Syrian Bank
              CSBK = 'CSBK'.freeze

              # Development Bank of Singapore
              DBSS = 'DBSS'.freeze

              # DCB Bank
              DCBL = 'DCBL'.freeze

              # Deutsche Bank
              DEUT = 'DEUT'.freeze

              # Dhanlaxmi Bank
              DLXB = 'DLXB'.freeze

              # Equitas Small Finance Bank
              ESFB = 'ESFB'.freeze

              # Federal Bank
              FDRL = 'FDRL'.freeze

              # HDFC Bank
              HDFC = 'HDFC'.freeze

              # IDBI
              IBKL = 'IBKL'.freeze

              # ICICI Bank
              ICIC = 'ICIC'.freeze

              # IDFC FIRST Bank
              IDFB = 'IDFB'.freeze

              # Indian Bank
              IDIB = 'IDIB'.freeze

              # Indusind Bank
              INDB = 'INDB'.freeze

              # Indian Overseas Bank
              IOBA = 'IOBA'.freeze

              # Jammu and Kashmir Bank
              JAKA = 'JAKA'.freeze

              # Janata Sahakari Bank (Pune)
              JSBP = 'JSBP'.freeze

              # Karnataka Bank
              KARB = 'KARB'.freeze

              # Kotak Mahindra Bank
              KKBK = 'KKBK'.freeze

              # Karur Vysya Bank
              KVBL = 'KVBL'.freeze

              # Lakshmi Vilas Bank - Corporate Banking
              LAVB_C = 'LAVB_C'.freeze

              # Lakshmi Vilas Bank - Retail Banking
              LAVB_R = 'LAVB_R'.freeze

              # Bank of Maharashtra
              MAHB = 'MAHB'.freeze

              # NKGSB Co-operative Bank
              NKGS = 'NKGS'.freeze

              # Oriental Bank of Commerce
              ORBC = 'ORBC'.freeze

              # Punjab & Maharashtra Co-operative Bank
              PMCB = 'PMCB'.freeze

              # Punjab & Sind Bank
              PSIB = 'PSIB'.freeze

              # Punjab National Bank - Retail Banking
              PUNB_R = 'PUNB_R'.freeze

              # RBL Bank
              RATN = 'RATN'.freeze

              # State Bank of Bikaner and Jaipur
              SBBJ = 'SBBJ'.freeze

              # State Bank of Hyderabad
              SBHY = 'SBHY'.freeze

              # State Bank of India
              SBIN = 'SBIN'.freeze

              # State Bank of Mysore
              SBMY = 'SBMY'.freeze

              # State Bank of Travancore
              SBTR = 'SBTR'.freeze

              # Standard Chartered Bank
              SCBL = 'SCBL'.freeze

              # South Indian Bank
              SIBL = 'SIBL'.freeze

              # State Bank of Patiala
              STBP = 'STBP'.freeze

              # Shamrao Vithal Co-operative Bank
              SVCB = 'SVCB'.freeze

              # Syndicate Bank
              SYNB = 'SYNB'.freeze

              # Tamilnadu Mercantile Bank
              TMBL = 'TMBL'.freeze

              # Tamilnadu State Apex Co-operative Bank
              TNSC = 'TNSC'.freeze

              # Union Bank of India
              UBIN = 'UBIN'.freeze

              # UCO Bank
              UCBA = 'UCBA'.freeze

              # United Bank of India
              UTBI = 'UTBI'.freeze

              # Axis Bank
              UTIB = 'UTIB'.freeze

              # Vijaya Bank
              VIJB = 'VIJB'.freeze

              # Yes Bank
              YESB = 'YESB'.freeze

              # Santander
              SN = 'SN'.freeze

              # Itau
              IT = 'IT'.freeze

              # Bradesco
              BR = 'BR'.freeze

              # Banco do Brasil
              BB = 'BB'.freeze

              # Webpay
              WP = 'WP'.freeze

              # Bancomer
              BN = 'BN'.freeze

              # Bancontact
              BCT = 'BCT'.freeze

              # PSE
              PS = 'PS'.freeze

              # Banco de Occidente
              BO = 'BO'.freeze

              # Industrial and Commercial Bank of China
              ICBC = 'ICBC'.freeze

              # China Merchants Bank
              CMBCHINA = 'CMBCHINA'.freeze

              # Agricultural Bank of China
              ABC = 'ABC'.freeze

              # China Construction Bank
              CCB = 'CCB'.freeze

              # Bank of Beijing
              BCCB = 'BCCB'.freeze

              # Bank of Communications
              BOCO = 'BOCO'.freeze

              # Industrial Bank
              CIB = 'CIB'.freeze

              # Bank of Nanjing
              NJCB = 'NJCB'.freeze

              # China Minsheng Banking Corp Ltd
              CMBC = 'CMBC'.freeze

              # China Everbright Bank
              CEB = 'CEB'.freeze

              # Bank of China
              BOC = 'BOC'.freeze

              # Ping An Bank
              PINGANBANK = 'PINGANBANK'.freeze

              # Bank of East Asia
              HKBEA = 'HKBEA'.freeze

              # Bank of Ningbo
              NBCB = 'NBCB'.freeze

              # China Citic Bank
              ECITIC = 'ECITIC'.freeze

              # Shenzhen Development Bank
              SDB = 'SDB'.freeze

              # Guangdong Development Bank
              GDB = 'GDB'.freeze

              # Bank of Shanghai
              SHB = 'SHB'.freeze

              # Shanghai Pudong Development Bank
              SPDB = 'SPDB'.freeze

              # China Post
              POST = 'POST'.freeze

              # BEIJING RURAL COMMERCIAL BANK
              BJRCB = 'BJRCB'.freeze

              # Hua Xia Bank Co Ltd'
              HXB = 'HXB'.freeze

              # Bank of Hangzhou
              HZBANK = 'HZBANK'.freeze

              # Shanghai Rural Commercial Bank
              SRCB = 'SRCB'.freeze

              # DirectDebit
              DB = 'DB'.freeze

              # Caixa
              CA = 'CA'.freeze

              # Interac Combined Pay-in
              CPI = 'CPI'.freeze

              # Servipag
              SP = 'SP'.freeze

              # Bank of Beijing
              BOB = 'BOB'.freeze

              # Bank for economic construction
              CCD = 'CCD'.freeze

              # China Merchants Bank
              CMB = 'CMB'.freeze

              # China Citic Bank
              CITIC = 'CITIC'.freeze

              # China Postal Savings Bank
              PSBC = 'PSBC'.freeze

              # China Union Pay
              QUICKPAY = 'QUICKPAY'.freeze

              # Shengzhen Ping An Bank
              SPABANK = 'SPABANK'.freeze

              # Yinlian Bank
              YLB = 'YLB'.freeze

              # Bancolombia
              PC = 'PC'.freeze

              # Bank Central Asia
              DK_BCA_IB = 'DK_BCA_IB'.freeze

              # Bank Rakyat Indonesia
              DK_BRI_IB = 'DK_BRI_IB'.freeze

              # BTN Bank
              BTN_IDR = 'BTN_IDR'.freeze

              # CIMB Clicks Indonesia
              DK_CIMBCLICKS_IB = 'DK_CIMBCLICKS_IB'.freeze

              # Danamon Bank
              DK_DANAMON_IB = 'DK_DANAMON_IB'.freeze

              # Mandiri Bank
              MDR_IDR = 'MDR_IDR'.freeze

              # Permata Bank
              DK_PERMATANET_IB = 'DK_PERMATANET_IB'.freeze

              # Virtual Account Bank
              VA = 'VA'.freeze

              # Netbanking
              NB = 'NB'.freeze

              # UPI
              UI = 'UI'.freeze

              # Spei
              SE = 'SE'.freeze

              # Banorte
              BQ = 'BQ'.freeze

              # 7-eleven stores
              CASH_711 = 'CASH-711'.freeze

              # Affin Bank
              FPX_ABB = 'FPX_ABB'.freeze
              AFFIN_EPG = 'AFFIN-EPG'.freeze

              # Alliance Bank
              FPX_ABMB = 'FPX_ABMB'.freeze

              # Am Online
              FPX_AMB = 'FPX_AMB'.freeze
              AMB_W2W = 'AMB-W2W'.freeze

              # Bank Islam
              FPX_BIMB  = 'FPX_BIMB'.freeze
              BANKISLAM = 'BANKISLAM'.freeze

              # Bank Muamalat
              FPX_BMMB = 'FPX_BMMB'.freeze

              # Bank Rakyat
              FPX_BKRM = 'FPX_BKRM'.freeze

              # Bank Simpanan Nasional
              FPX_BSN = 'FPX_BSN'.freeze

              # CIMB Clicks Bank
              CIMB_MYR       = 'CIMB_MYR'.freeze
              FPX_CIMBCLICKS = 'FPX_CIMBCLICKS'.freeze
              CIMB_CLICKS    = 'CIMB-CLICKS'.freeze

              # FPX
              FPX = 'FPX'.freeze

              # HLB Connect
              FPX_HLB = 'FPX_HLB'.freeze
              HLB_ONL = 'HLB-ONL'.freeze

              # Hong Leong Bank
              HLE_MYR = 'HLE_MYR'.freeze

              # jmpay
              JOMPAY_PHP = 'jompay.php'.freeze

              # Kuwait Finance House
              FPX_KFH = 'FPX_KFH'.freeze

              # May Bank
              MAY_MYR = 'MAY_MYR'.freeze

              # Maybank2u
              FPX_MB2U = 'FPX_MB2U'.freeze
              MB2U = 'MB2U'.freeze

              # OCBC Bank
              FPX_OCBC = 'FPX_OCBC'.freeze

              # PBeBank
              FPX_PBB = 'FPX_PBB'.freeze
              PUBLICKBANK = 'PUBLICKBANK'.freeze

              # Public Bank
              PBE_MYR = 'PBE_MYR'.freeze

              # RHB Bank
              RHB_MYR = 'RHB_MYR'.freeze

              # RHB Now
              FPX_RHB = 'FPX_RHB'.freeze
              RHB_ONL = 'RHB-ONL'.freeze

              # Stand Chart Bank
              FPX_SCB = 'FPX_SCB'.freeze

              # UOB Bank
              FPX_UOB = 'FPX_UOB'.freeze

              # BCP
              BC = 'BC'.freeze

              # Interbank
              IB = 'IB'.freeze

              # Pago Efectivo
              EF = 'EF'.freeze

              # BBVA
              BP = 'BP'.freeze

              # PagoExpress
              PE = 'PE'.freeze

              # Post Finance
              PF = 'PF'.freeze

              # Bangkok Bank
              BBL_IB_U = 'BBL_IB_U'.freeze

              # Kasikornbank PAYPLUS
              KBANK_PAYPLUS = 'KBANK_PAYPLUS'.freeze

              # Bank of Ayudhya (Krungsri)
              BAY_IB_U = 'BAY_IB_U'.freeze

              # Krung Thai Bank
              KTB_IB_U = 'KTB_IB_U'.freeze

              # Siam Commercial Bank
              SCB_IB_U = 'SCB_IB_U'.freeze

              # Abitab
              AI = 'AI'.freeze

              # Dragonpay
              DRAGONPAY = 'DRAGONPAY'.freeze

              # SG eNETS
              ENETS_D = 'ENETS-D'.freeze

              # singpost
              SINGPOST_PHP = 'singpost.php'.freeze

              # VTC-Pay VPBank
              VTCP_VPBANK = 'VTCP_VPBANK'.freeze

              # VTC-Pay ABBANK
              VTCP_ABBANK = 'VTCP_ABBANK'.freeze

              # VTC-Pay ACB
              VTCP_ACB = 'VTCP_ACB'.freeze

              # VTC-Pay Agribank
              VTCP_AGRIBANK = 'VTCP_AGRIBANK'.freeze

              # VTC-Pay BACABANK
              VTCP_BACABANK = 'VTCP_BACABANK'.freeze

              # VTC-Pay BIDV
              VTCP_BIDV = 'VTCP_BIDV'.freeze

              # VTC-Pay BVB
              VTCP_BVB = 'VTCP_BVB'.freeze

              # VTC-Pay DongABank
              VTCP_DONGABANK = 'VTCP_DONGABANK'.freeze

              # VTC-Pay Eximbank
              VTCP_EXIMBANK = 'VTCP_EXIMBANK'.freeze

              # VTC-Pay GPBank
              VTCP_GPBANK = 'VTCP_GPBANK'.freeze

              # VTC-Pay HDBank
              VTCP_HDBANK = 'VTCP_HDBANK'.freeze

              # VTC-Pay LienVietPostBank
              VTCP_LVPB = 'VTCP_LVPB'.freeze

              # VTC-Pay MB
              VTCP_MB = 'VTCP_MB'.freeze

              # VTC-Pay MaritimeBank
              VTCP_MARITIMEBANK = 'VTCP_MARITIMEBANK'.freeze

              # VTC-Pay NamABank
              VTCP_NAMABANK = 'VTCP_NAMABANK'.freeze

              # VTC-Pay Navibank
              VTCP_NAVIBANK = 'VTCP_NAVIBANK'.freeze

              # VTC-Pay Oceanbank
              VTCP_OCEANBANK = 'VTCP_OCEANBANK'.freeze

              # VTC-Pay PGBank
              VTCP_PGBANK = 'VTCP_PGBANK'.freeze

              # VTC-Pay PHUONGDONG
              VTCP_PHUONGDONG = 'VTCP_PHUONGDONG'.freeze

              # VTC-Pay SHB
              VTCP_SHB = 'VTCP_SHB'.freeze

              # VTC-Pay Sacombank
              VTCP_SACOMBANK = 'VTCP_SACOMBANK'.freeze

              # VTC-Pay SaigonBank
              VTCP_SAIGONBANK = 'VTCP-SAIGONBANK'.freeze

              # VTC-Pay SeaABank
              VTCP_SEAABANK = 'VTCP_SEAABANK'.freeze

              # VTC-Pay Techcombank
              VTCP_TECHCOMBANK = 'VTCP_TECHCOMBANK'.freeze

              # VTC-Pay TienPhong Bank
              VTCP_TIENPHONGBANK = 'VTCP_TIENPHONGBANK'.freeze

              # VTC-Pay VIB
              VTCP_VIB = 'VTCP_VIB'.freeze

              # VTC-Pay VietABank
              VTCP_VIETABANK = 'VTCP_VIETABANK'.freeze

              # VTC-Pay Vietcombank
              VTCP_VIETCOMBANK = 'VTCP_VIETCOMBANK'.freeze

              # VTC-Pay Vietinbank
              VTCP_VIETINBANK = 'VTCP_VIETINBANK'.freeze

              # DBS
              DBS = 'ENETS-D_DBS'.freeze

              # UOB
              UOB = 'ENETS-D_UOB'.freeze

              # OCBC
              OCBC = 'ENETS-D_OCBC'.freeze

              # SCB
              SCB = 'ENETS-D_SCB'.freeze

              # BL
              BLK = 'BLK'.freeze

              # TrueLayer
              TRL = 'TRL'.freeze

              # Latipay
              PID = 'PID'.freeze

              # Latipay
              POLI = 'POLI'.freeze

            end
          end
        end
      end
    end
  end
end
