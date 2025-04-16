RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::OnlineBanking::PayOut do
  let(:test_required_fields) do
    %i[transaction_id amount currency billing_first_name billing_last_name billing_state billing_country]
  end
  let(:test_required_field_values) { %i[currency bank_account_type payment_type] }
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) do
    request = described_class.new config

    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.number digits: 2 # different currencies have different exponents
    request.currency           = %w(CNY MYR THB IDR INR ARS CAD CLP COP MXN PEN UYU).sample
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.notification_url   = Faker::Internet.url
    request.billing_first_name = Faker::Name.first_name
    request.billing_last_name  = Faker::Name.last_name
    request.billing_state      = Faker::Address.state_abbr
    request.billing_country    = Faker::Address.country_code

    request
  end

  describe 'when id_card_number' do
    it 'when build document with id_card_number' do
      request.id_card_number = 1234

      expect(request.build_document).to include '<id_card_number>1234</id_card_number>'
    end

    it 'with empty value' do
      request.id_card_number = nil

      expect(request.build_document).to_not include 'id_card_number'
    end

    it 'with invalid value' do
      expect { request.id_card_number = Faker::Lorem.characters number: 31 }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when document_type' do
    it 'with empty value' do
      request.document_type = nil

      expect(request.build_document).to_not include 'document_type'
    end

    it 'with proper value' do
      request.document_type = Faker::Lorem.characters number: 10

      expect(request.build_document).to include "<document_type>#{request.document_type}</document_type>"
    end

    it 'with invalid value' do
      expect { request.document_type = Faker::Lorem.characters number: 11 }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when account_id' do
    it 'with empty value' do
      request.account_id = nil

      expect(request.build_document).to_not include 'account_id'
    end

    it 'with proper value' do
      request.account_id = Faker::Lorem.characters number: 255

      expect(request.build_document).to include "<account_id>#{request.account_id}</account_id>"
    end

    it 'with invalid value' do
      expect { request.account_id = Faker::Lorem.characters number: 256 }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when user_id' do
    it 'with empty value' do
      request.user_id = nil

      expect(request.build_document).to_not include 'user_id'
    end

    it 'with proper value' do
      request.user_id = Faker::Lorem.characters number: 255

      expect(request.build_document).to include "<user_id>#{request.user_id}</user_id>"
    end

    it 'with invalid value' do
      expect { request.user_id = Faker::Lorem.characters number: 256 }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when BRL currency validations' do
    before do
      request.currency  = 'BRL'
      request.bank_code = '001'
      request.bank_name = 'BANCO DO BRASIL S.A.'
    end

    it 'with proper parameters' do
      expect { request.build_document }.to_not raise_error
    end

    it 'without bank_code' do
      request.bank_code = nil

      expect { request.build_document }.to_not raise_error
    end

    it 'without bank_name' do
      request.bank_name = nil

      expect { request.build_document }.to_not raise_error
    end

    it 'without bank_name and bank_code' do
      request.bank_code = nil
      request.bank_name = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when optional parameters' do
    it 'with bank_account_type' do
      request.bank_account_type = 'C'

      expect(request.build_document).to include '<bank_account_type>C</bank_account_type>'
    end

    it 'with bank_code' do
      request.bank_code = '002'

      expect(request.build_document).to include '<bank_code>002</bank_code>'
    end

    it 'with bank_name' do
      request.bank_name = 'BANCO DA AMAZONIA S.A.'

      expect(request.build_document).to include "<bank_name>#{request.bank_name}</bank_name>"
    end

    it 'with bank_branch' do
      request.bank_branch = Faker::Lorem.word

      expect(request.build_document).to include "<bank_branch>#{request.bank_branch}</bank_branch>"
    end

    it 'with bank_account_name' do
      request.bank_account_name = Faker::Lorem.word

      expect(request.build_document).to include "<bank_account_name>#{request.bank_account_name}</bank_account_name>"
    end

    it 'with bank_account_number' do
      request.bank_account_number = Faker::Internet.uuid

      expect(request.build_document)
        .to include "<bank_account_number>#{request.bank_account_number}</bank_account_number>"
    end

    it 'with bank_account_verification_digit' do
      request.bank_account_verification_digit = digit = 1

      expect(request.build_document)
        .to include "<bank_account_verification_digit>#{digit}</bank_account_verification_digit>"
    end

    it 'with bank_province' do
      request.bank_province = 'province'

      expect(request.build_document).to include "<bank_province>#{request.bank_province}</bank_province>"
    end

    it 'with payment_type' do
      request.payment_type = GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::
          PayoutPaymentTypes.all.sample

      expect(request.build_document).to include "<payment_type>#{request.payment_type}</payment_type>"
    end

    it 'with pix_key' do
      request.pix_key = Faker::Internet.uuid

      expect(request.build_document).to include "<pix_key>#{request.pix_key}</pix_key>"
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'birth date attributes examples'
  include_examples 'document attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payer attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'pix attributes examples'
end
