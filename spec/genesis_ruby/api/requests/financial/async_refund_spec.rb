# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::AsyncRefund do
  let(:test_required_fields) { %i[transaction_id reference_id amount currency] }
  let(:test_required_field_values) do
    %w(currency bank_account_type credit_reason_indicator_1 credit_reason_indicator_2 ticket_change_indicator)
  end
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

    request.transaction_id             = 'trx-1'
    request.usage                      = 'Refund usage'
    request.remote_ip                  = '127.0.0.1'
    request.amount                     = '1.00'
    request.currency                   = 'usd'
    request.reference_id               = 'ref-1'
    request.beneficiary_bank_code      = 'bbc'
    request.beneficiary_name           = 'John Doe'
    request.beneficiary_account_number = 'ban'
    request.bank                       = 'Bank'
    request.bank_branch                = 'Branch'
    request.bank_account               = 'acc'
    request.bank_account_type          = 'C'
    request.__send__('credit_reason_indicator_1=', 'A')
    request.__send__('credit_reason_indicator_2=', 'B')
    request.ticket_change_indicator = 'C'

    request
  end

  let(:expected_document) do
    <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <payment_transaction>
        <transaction_type>async_refund</transaction_type>
        <transaction_id>trx-1</transaction_id>
        <usage>Refund usage</usage>
        <remote_ip>127.0.0.1</remote_ip>
        <amount>100</amount>
        <currency>USD</currency>
        <reference_id>ref-1</reference_id>
        <beneficiary_bank_code>bbc</beneficiary_bank_code>
        <beneficiary_name>John Doe</beneficiary_name>
        <beneficiary_account_number>ban</beneficiary_account_number>
        <bank>Bank</bank>
        <bank_branch>Branch</bank_branch>
        <bank_account>acc</bank_account>
        <bank_account_type>C</bank_account_type>
        <travel>
          <ticket>
            <credit_reason_indicator_1>A</credit_reason_indicator_1>
            <credit_reason_indicator_2>B</credit_reason_indicator_2>
            <ticket_change_indicator>C</ticket_change_indicator>
          </ticket>
        </travel>
      </payment_transaction>
    XML
  end

  it_behaves_like 'base request examples'
  it_behaves_like 'financial attributes examples'
  it_behaves_like 'reference attributes examples'
  it_behaves_like 'payment attributes examples'
  it_behaves_like 'refund bank attributes examples'
  it_behaves_like 'refund beneficiary attributes examples'
  it_behaves_like 'refund travel ticket attributes examples'

  describe 'when async refund document' do
    def payment_transaction_children(document)
      Nokogiri::XML(document).xpath('/payment_transaction/*').map(&:name)
    end

    def required_only_request
      required_request = described_class.new config

      required_request.transaction_id = 'trx-1'
      required_request.reference_id   = 'ref-1'
      required_request.amount         = '1.00'
      required_request.currency       = 'USD'

      required_request
    end

    it 'with expected document' do
      expect(request.build_document).to eq expected_document
    end

    it 'with ASYNC_REFUND transaction type' do
      expect(request.__send__(:transaction_type)).to eq GenesisRuby::Api::Constants::Transactions::ASYNC_REFUND
    end

    it 'with async_refund transaction type element' do
      expect(request.build_document).to include '<transaction_type>async_refund</transaction_type>'
    end

    it 'with only required attributes' do
      expect(payment_transaction_children(required_only_request.build_document))
        .to eq %w(transaction_type transaction_id amount currency reference_id)
    end

    it 'without remote_ip and beneficiary attributes' do
      optional = %w(remote_ip beneficiary_bank_code beneficiary_name beneficiary_account_number)
      optional.each { |name| request.__send__("#{name}=", nil) }

      expect(payment_transaction_children(request.build_document) & optional).to be_empty
    end

    it 'with empty amount and valid currency' do
      request.amount = ''

      expect { request.build_document }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when lower-case allowed values' do
    {
      'bank_account_type'         => 'c',
      'credit_reason_indicator_1' => 'a',
      'credit_reason_indicator_2' => 'a',
      'ticket_change_indicator'   => 'n'
    }.each do |name, value|
      it "with #{name} #{value}" do
        request.__send__("#{name}=", value)

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end
  end

  describe 'when async refund class' do
    refund_mixins = GenesisRuby::Api::Mixins::Requests::Financial::Refund

    it 'with Base::Reference superclass' do
      expect(described_class.superclass).to eq GenesisRuby::Api::Requests::Base::Reference
    end

    it 'with refund mixins' do
      expect(described_class.ancestors).to include(
        refund_mixins::BankAttributes, refund_mixins::BeneficiaryAttributes, refund_mixins::TravelTicketAttributes
      )
    end

    it 'without installment and travel data mixins' do
      expect(described_class.ancestors).to_not include(
        GenesisRuby::Api::Mixins::Requests::Financial::Cards::InstallmentAttributes,
        GenesisRuby::Api::Mixins::Requests::Financial::TravelData::TravelAttributes
      )
    end
  end

  describe 'when async refund accessors' do
    accessors = %w(
      transaction_id usage remote_ip amount currency reference_id
      beneficiary_bank_code beneficiary_name beneficiary_account_number
      bank bank_branch bank_account bank_account_type
      credit_reason_indicator_1 credit_reason_indicator_2 ticket_change_indicator
    )

    it 'with readers and writers' do
      expect(request).to respond_to(*accessors.flat_map { |name| [name, "#{name}="] })
    end

    it 'without installment accessors' do
      expect(request).to_not respond_to(:installment_plan_id, :installment_plan_reference)
    end

    it 'with upper-cased currency' do
      request.currency = 'usd'

      expect(request.currency).to eq 'USD'
    end

    it 'with unchanged amount' do
      request.amount = '1.00'

      expect(request.amount).to eq '1.00'
    end

    it 'with empty unset currency' do
      expect(described_class.new(config).currency).to eq ''
    end
  end

  describe 'when async refund api_config' do
    def api_config_snapshot(request_class)
      request_class.new(config).api_config.slice(:protocol, :port, :type, :format, :authorization, :url)
    end

    it 'with Refund api_config' do
      expect(api_config_snapshot(described_class))
        .to eq api_config_snapshot(GenesisRuby::Api::Requests::Financial::Refund)
    end

    it 'with gateway process url' do
      expect(api_config_snapshot(described_class)[:url])
        .to eq 'https://staging.gate.emerchantpay.net:443/process/example_token/'
    end

    it 'with force_smart_routing Refund api_config' do
      config.force_smart_routing = true

      expect(api_config_snapshot(described_class))
        .to eq api_config_snapshot(GenesisRuby::Api::Requests::Financial::Refund)
    end

    it 'with force_smart_routing transactions url' do
      config.force_smart_routing = true

      expect(api_config_snapshot(described_class)[:url]).to end_with '/transactions'
    end
  end
end
