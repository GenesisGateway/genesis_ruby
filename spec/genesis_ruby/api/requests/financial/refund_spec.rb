RSpec.describe GenesisRuby::Api::Requests::Financial::Refund do
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
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address

    request.beneficiary_bank_code      = 'beneficiary_bank_code'
    request.beneficiary_name           = 'beneficiary_name'
    request.beneficiary_account_number = 'beneficiary_account_number'
    request.bank                       = 'bank'
    request.bank_branch                = 'bank_branch'
    request.bank_account               = 'bank_account'
    request.bank_account_type          = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
        BankAccountTypes::INTERNATIONAL

    request
  end

  it 'when bank_account_type with invalid value' do
    expect { request.bank_account_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
  end

  describe 'when beneficiary attributes' do
    it 'with beneficiary_bank_code' do
      expect(request.build_document)
        .to include "<beneficiary_bank_code>#{request.beneficiary_bank_code}</beneficiary_bank_code>"
    end

    it 'with beneficiary_name' do
      expect(request.build_document).to include "<beneficiary_name>#{request.beneficiary_name}</beneficiary_name>"
    end

    it 'with beneficiary_account_number' do
      expect(request.build_document)
        .to include "<beneficiary_account_number>#{request.beneficiary_account_number}</beneficiary_account_number>"
    end
  end

  describe 'when bank attributes' do
    it 'with bank' do
      expect(request.build_document).to include "<bank>#{request.bank}</bank>"
    end

    it 'with bank_branch' do
      expect(request.build_document).to include "<bank_branch>#{request.bank_branch}</bank_branch>"
    end

    it 'with bank_account' do
      expect(request.build_document).to include "<bank_account>#{request.bank_account}</bank_account>"
    end

    it 'with bank_account_type' do
      expect(request.build_document).to include "<bank_account_type>#{request.bank_account_type}</bank_account_type>"
    end
  end

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'reference attributes examples'
  include_examples 'payment attributes examples'
end
