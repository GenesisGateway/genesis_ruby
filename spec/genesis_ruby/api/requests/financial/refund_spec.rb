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

  describe 'when refund mixin accessors' do
    refund_mixins = GenesisRuby::Api::Mixins::Requests::Financial::Refund

    {
      'BeneficiaryAttributes'  => %w(beneficiary_bank_code beneficiary_name beneficiary_account_number),
      'BankAttributes'         => %w(bank bank_branch bank_account bank_account_type),
      'TravelTicketAttributes' => %w(credit_reason_indicator_1 credit_reason_indicator_2 ticket_change_indicator)
    }.each do |mixin_name, names|
      names.each do |name|
        it "with #{name} accessors from #{mixin_name}" do
          mixin = refund_mixins.const_get(mixin_name)

          expect([described_class.instance_method(name).owner, described_class.instance_method("#{name}=").owner])
            .to eq [mixin, mixin]
        end
      end
    end
  end

  it_behaves_like 'refund bank attributes examples'
  it_behaves_like 'refund beneficiary attributes examples'
  it_behaves_like 'refund travel ticket attributes examples'

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'reference attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'installment attributes examples'
  include_examples 'commercial card attributes examples'
end
