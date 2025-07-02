# frozen_string_literal: true

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
              ABPB = 'ABPB'

              # Airtel Payments Bank
              AIRP = 'AIRP'

              # Allahabad Bank
              ALLA = 'ALLA'

              # Andhra Bank
              ANDB = 'ANDB'

              # Bank of Baroda - Retail Banking
              BARB_R = 'BARB_R'

              # Bank of Bahrein and Kuwait
              BBKM = 'BBKM'

              # Dena Bank
              BKDN = 'BKDN'

              # Bank of India
              BKID = 'BKID'

              # Central Bank of India
              CBIN = 'CBIN'

              # City Union Bank
              CIUB = 'CIUB'

              # Canara Bank
              CNRB = 'CNRB'

              # Corporation Bank
              CORP = 'CORP'

              # Cosmos Co-operative Bank
              COSB = 'COSB'

              # Catholic Syrian Bank
              CSBK = 'CSBK'

              # Development Bank of Singapore
              DBSS = 'DBSS'

              # DCB Bank
              DCBL = 'DCBL'

              # Deutsche Bank
              DEUT = 'DEUT'

              # Dhanlaxmi Bank
              DLXB = 'DLXB'

              # Equitas Small Finance Bank
              ESFB = 'ESFB'

              # Federal Bank
              FDRL = 'FDRL'

              # HDFC Bank
              HDFC = 'HDFC'

              # IDBI
              IBKL = 'IBKL'

              # ICICI Bank
              ICIC = 'ICIC'

              # IDFC FIRST Bank
              IDFB = 'IDFB'

              # Indian Bank
              IDIB = 'IDIB'

              # Indusind Bank
              INDB = 'INDB'

              # Indian Overseas Bank
              IOBA = 'IOBA'

              # Jammu and Kashmir Bank
              JAKA = 'JAKA'

              # Janata Sahakari Bank (Pune)
              JSBP = 'JSBP'

              # Karnataka Bank
              KARB = 'KARB'

              # Kotak Mahindra Bank
              KKBK = 'KKBK'

              # Karur Vysya Bank
              KVBL = 'KVBL'

              # Lakshmi Vilas Bank - Corporate Banking
              LAVB_C = 'LAVB_C'

              # Lakshmi Vilas Bank - Retail Banking
              LAVB_R = 'LAVB_R'

              # Bank of Maharashtra
              MAHB = 'MAHB'

              # NKGSB Co-operative Bank
              NKGS = 'NKGS'

              # Oriental Bank of Commerce
              ORBC = 'ORBC'

              # Punjab & Maharashtra Co-operative Bank
              PMCB = 'PMCB'

              # Punjab & Sind Bank
              PSIB = 'PSIB'

              # Punjab National Bank - Retail Banking
              PUNB_R = 'PUNB_R'

              # RBL Bank
              RATN = 'RATN'

              # State Bank of Bikaner and Jaipur
              SBBJ = 'SBBJ'

              # State Bank of Hyderabad
              SBHY = 'SBHY'

              # State Bank of India
              SBIN = 'SBIN'

              # State Bank of Mysore
              SBMY = 'SBMY'

              # State Bank of Travancore
              SBTR = 'SBTR'

              # Standard Chartered Bank
              SCBL = 'SCBL'

              # South Indian Bank
              SIBL = 'SIBL'

              # State Bank of Patiala
              STBP = 'STBP'

              # Shamrao Vithal Co-operative Bank
              SVCB = 'SVCB'

              # Syndicate Bank
              SYNB = 'SYNB'

              # Tamilnadu Mercantile Bank
              TMBL = 'TMBL'

              # Tamilnadu State Apex Co-operative Bank
              TNSC = 'TNSC'

              # Union Bank of India
              UBIN = 'UBIN'

              # UCO Bank
              UCBA = 'UCBA'

              # United Bank of India
              UTBI = 'UTBI'

              # Axis Bank
              UTIB = 'UTIB'

              # Vijaya Bank
              VIJB = 'VIJB'

              # Yes Bank
              YESB = 'YESB'

              # Santander
              SN = 'SN'

              # Itau
              IT = 'IT'

              # Bradesco
              BR = 'BR'

              # Banco do Brasil
              BB = 'BB'

              # Webpay
              WP = 'WP'

              # Bancomer
              BN = 'BN'

              # Bancontact
              BCT = 'BCT'

              # PSE
              PS = 'PS'

              # Banco de Occidente
              BO = 'BO'

              # Industrial and Commercial Bank of China
              ICBC = 'ICBC'

              # China Merchants Bank
              CMBCHINA = 'CMBCHINA'

              # Agricultural Bank of China
              ABC = 'ABC'

              # China Construction Bank
              CCB = 'CCB'

              # Bank of Beijing
              BCCB = 'BCCB'

              # Bank of Communications
              BOCO = 'BOCO'

              # Industrial Bank
              CIB = 'CIB'

              # Bank of Nanjing
              NJCB = 'NJCB'

              # China Minsheng Banking Corp Ltd
              CMBC = 'CMBC'

              # China Everbright Bank
              CEB = 'CEB'

              # Bank of China
              BOC = 'BOC'

              # Ping An Bank
              PINGANBANK = 'PINGANBANK'

              # Bank of East Asia
              HKBEA = 'HKBEA'

              # Bank of Ningbo
              NBCB = 'NBCB'

              # China Citic Bank
              ECITIC = 'ECITIC'

              # Shenzhen Development Bank
              SDB = 'SDB'

              # Guangdong Development Bank
              GDB = 'GDB'

              # Bank of Shanghai
              SHB = 'SHB'

              # Shanghai Pudong Development Bank
              SPDB = 'SPDB'

              # China Post
              POST = 'POST'

              # BEIJING RURAL COMMERCIAL BANK
              BJRCB = 'BJRCB'

              # Hua Xia Bank Co Ltd'
              HXB = 'HXB'

              # Bank of Hangzhou
              HZBANK = 'HZBANK'

              # Shanghai Rural Commercial Bank
              SRCB = 'SRCB'

              # DirectDebit
              DB = 'DB'

              # Caixa
              CA = 'CA'

              # Interac Combined Pay-in
              CPI = 'CPI'

              # Servipag
              SP = 'SP'

              # Bank of Beijing
              BOB = 'BOB'

              # Bank for economic construction
              CCD = 'CCD'

              # China Merchants Bank
              CMB = 'CMB'

              # China Citic Bank
              CITIC = 'CITIC'

              # China Postal Savings Bank
              PSBC = 'PSBC'

              # China Union Pay
              QUICKPAY = 'QUICKPAY'

              # Shengzhen Ping An Bank
              SPABANK = 'SPABANK'

              # Yinlian Bank
              YLB = 'YLB'

              # Bancolombia
              PC = 'PC'

              # Bank Central Asia
              DK_BCA_IB = 'DK_BCA_IB'

              # Bank Rakyat Indonesia
              DK_BRI_IB = 'DK_BRI_IB'

              # BTN Bank
              BTN_IDR = 'BTN_IDR'

              # CIMB Clicks Indonesia
              DK_CIMBCLICKS_IB = 'DK_CIMBCLICKS_IB'

              # Danamon Bank
              DK_DANAMON_IB = 'DK_DANAMON_IB'

              # Mandiri Bank
              MDR_IDR = 'MDR_IDR'

              # Permata Bank
              DK_PERMATANET_IB = 'DK_PERMATANET_IB'

              # Virtual Account Bank
              VA = 'VA'

              # Netbanking
              NB = 'NB'

              # UPI
              UI = 'UI'

              # Spei
              SE = 'SE'

              # Banorte
              BQ = 'BQ'

              # 7-eleven stores
              CASH_711 = 'CASH-711'

              # Affin Bank
              FPX_ABB = 'FPX_ABB'
              AFFIN_EPG = 'AFFIN-EPG'

              # Alliance Bank
              FPX_ABMB = 'FPX_ABMB'

              # Am Online
              FPX_AMB = 'FPX_AMB'
              AMB_W2W = 'AMB-W2W'

              # Bank Islam
              FPX_BIMB  = 'FPX_BIMB'
              BANKISLAM = 'BANKISLAM'

              # Bank Muamalat
              FPX_BMMB = 'FPX_BMMB'

              # Bank Rakyat
              FPX_BKRM = 'FPX_BKRM'

              # Bank Simpanan Nasional
              FPX_BSN = 'FPX_BSN'

              # CIMB Clicks Bank
              CIMB_MYR       = 'CIMB_MYR'
              FPX_CIMBCLICKS = 'FPX_CIMBCLICKS'
              CIMB_CLICKS    = 'CIMB-CLICKS'

              # FPX
              FPX = 'FPX'

              # HLB Connect
              FPX_HLB = 'FPX_HLB'
              HLB_ONL = 'HLB-ONL'

              # Hong Leong Bank
              HLE_MYR = 'HLE_MYR'

              # jmpay
              JOMPAY_PHP = 'jompay.php'

              # Kuwait Finance House
              FPX_KFH = 'FPX_KFH'

              # May Bank
              MAY_MYR = 'MAY_MYR'

              # Maybank2u
              FPX_MB2U = 'FPX_MB2U'
              MB2U = 'MB2U'

              # OCBC Bank
              FPX_OCBC = 'FPX_OCBC'

              # PBeBank
              FPX_PBB = 'FPX_PBB'
              PUBLICKBANK = 'PUBLICKBANK'

              # Public Bank
              PBE_MYR = 'PBE_MYR'

              # RHB Bank
              RHB_MYR = 'RHB_MYR'

              # RHB Now
              FPX_RHB = 'FPX_RHB'
              RHB_ONL = 'RHB-ONL'

              # Stand Chart Bank
              FPX_SCB = 'FPX_SCB'

              # UOB Bank
              FPX_UOB = 'FPX_UOB'

              # BCP
              BC = 'BC'

              # Interbank
              IB = 'IB'

              # Pago Efectivo
              EF = 'EF'

              # BBVA
              BP = 'BP'

              # PagoExpress
              PE = 'PE'

              # Post Finance
              PF = 'PF'

              # Bangkok Bank
              BBL_IB_U = 'BBL_IB_U'

              # Kasikornbank PAYPLUS
              KBANK_PAYPLUS = 'KBANK_PAYPLUS'

              # Bank of Ayudhya (Krungsri)
              BAY_IB_U = 'BAY_IB_U'

              # Krung Thai Bank
              KTB_IB_U = 'KTB_IB_U'

              # Siam Commercial Bank
              SCB_IB_U = 'SCB_IB_U'

              # Abitab
              AI = 'AI'

              # Dragonpay
              DRAGONPAY = 'DRAGONPAY'

              # SG eNETS
              ENETS_D = 'ENETS-D'

              # singpost
              SINGPOST_PHP = 'singpost.php'

              # VTC-Pay VPBank
              VTCP_VPBANK = 'VTCP_VPBANK'

              # VTC-Pay ABBANK
              VTCP_ABBANK = 'VTCP_ABBANK'

              # VTC-Pay ACB
              VTCP_ACB = 'VTCP_ACB'

              # VTC-Pay Agribank
              VTCP_AGRIBANK = 'VTCP_AGRIBANK'

              # VTC-Pay BACABANK
              VTCP_BACABANK = 'VTCP_BACABANK'

              # VTC-Pay BIDV
              VTCP_BIDV = 'VTCP_BIDV'

              # VTC-Pay BVB
              VTCP_BVB = 'VTCP_BVB'

              # VTC-Pay DongABank
              VTCP_DONGABANK = 'VTCP_DONGABANK'

              # VTC-Pay Eximbank
              VTCP_EXIMBANK = 'VTCP_EXIMBANK'

              # VTC-Pay GPBank
              VTCP_GPBANK = 'VTCP_GPBANK'

              # VTC-Pay HDBank
              VTCP_HDBANK = 'VTCP_HDBANK'

              # VTC-Pay LienVietPostBank
              VTCP_LVPB = 'VTCP_LVPB'

              # VTC-Pay MB
              VTCP_MB = 'VTCP_MB'

              # VTC-Pay MaritimeBank
              VTCP_MARITIMEBANK = 'VTCP_MARITIMEBANK'

              # VTC-Pay NamABank
              VTCP_NAMABANK = 'VTCP_NAMABANK'

              # VTC-Pay Navibank
              VTCP_NAVIBANK = 'VTCP_NAVIBANK'

              # VTC-Pay Oceanbank
              VTCP_OCEANBANK = 'VTCP_OCEANBANK'

              # VTC-Pay PGBank
              VTCP_PGBANK = 'VTCP_PGBANK'

              # VTC-Pay PHUONGDONG
              VTCP_PHUONGDONG = 'VTCP_PHUONGDONG'

              # VTC-Pay SHB
              VTCP_SHB = 'VTCP_SHB'

              # VTC-Pay Sacombank
              VTCP_SACOMBANK = 'VTCP_SACOMBANK'

              # VTC-Pay SaigonBank
              VTCP_SAIGONBANK = 'VTCP-SAIGONBANK'

              # VTC-Pay SeaABank
              VTCP_SEAABANK = 'VTCP_SEAABANK'

              # VTC-Pay Techcombank
              VTCP_TECHCOMBANK = 'VTCP_TECHCOMBANK'

              # VTC-Pay TienPhong Bank
              VTCP_TIENPHONGBANK = 'VTCP_TIENPHONGBANK'

              # VTC-Pay VIB
              VTCP_VIB = 'VTCP_VIB'

              # VTC-Pay VietABank
              VTCP_VIETABANK = 'VTCP_VIETABANK'

              # VTC-Pay Vietcombank
              VTCP_VIETCOMBANK = 'VTCP_VIETCOMBANK'

              # VTC-Pay Vietinbank
              VTCP_VIETINBANK = 'VTCP_VIETINBANK'

              # DBS
              DBS = 'ENETS-D_DBS'

              # UOB
              UOB = 'ENETS-D_UOB'

              # OCBC
              OCBC = 'ENETS-D_OCBC'

              # SCB
              SCB = 'ENETS-D_SCB'

              # BL
              BLK = 'BLK'

              # TrueLayer
              TRL = 'TRL'

              # Latipay
              PID = 'PID'

              # Latipay
              POLI = 'POLI'

            end
          end
        end
      end
    end
  end
end
