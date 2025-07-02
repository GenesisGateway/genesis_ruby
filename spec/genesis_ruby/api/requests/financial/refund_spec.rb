# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Refund do
  let(:test_required_fields) { %i[transaction_id reference_id amount currency] }
  let(:test_required_field_values) { %i[currency] }
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
    request.reference_id       = Faker::Internet.uuid

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
    request.bank_account_type = 'invalid'

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
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

  describe 'when Level 3 Travel Data attributes' do
    it 'without attributes' do
      expect(request.build_document).to_not include '<travel>'
    end

    it 'when credit_reason_indicator_1 with valid value' do
      request.credit_reason_indicator_1 = indicator = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
          CreditReasonIndicators.all.sample

      expect(request.build_document).to include "<credit_reason_indicator_1>#{indicator}</credit_reason_indicator_1>"
    end

    it 'when credit_reason_indicator_1 with invalid value' do
      request.credit_reason_indicator_1 = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'when credit_reason_indicator_2 with valid value' do
      request.credit_reason_indicator_2 = indicator = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
          CreditReasonIndicators.all.sample

      expect(request.build_document).to include "<credit_reason_indicator_2>#{indicator}</credit_reason_indicator_2>"
    end

    it 'when credit_reason_indicator_2 with invalid value' do
      request.credit_reason_indicator_2 = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'when ticket_change_indicator with valid value' do
      request.ticket_change_indicator = indicator = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
          TicketChangeIndicators.all.sample

      expect(request.build_document).to include "<ticket_change_indicator>#{indicator}</ticket_change_indicator>"
    end

    it 'when ticket_change_indicator with invalid value' do
      request.ticket_change_indicator = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    describe 'when structure' do
      let(:travel_request) do
        request.credit_reason_indicator_1 = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
              CreditReasonIndicators.all.sample
        request.credit_reason_indicator_2 = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
              CreditReasonIndicators.all.sample
        request.ticket_change_indicator   = GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
              TicketChangeIndicators.all.sample

        request
      end

      it 'with ticket node' do
        expect(travel_request.build_document).to include '<ticket>'
      end

      it 'with travel node' do
        expect(travel_request.build_document).to include '<travel>'
      end
    end
  end

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'reference attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'installment attributes examples'
end
