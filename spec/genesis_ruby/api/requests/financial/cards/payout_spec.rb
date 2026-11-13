# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Payout do
  let(:test_required_fields) do
    %i[
      transaction_id
      amount
      currency
      card_holder
      card_number
      expiration_month
      expiration_year
    ]
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

    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone_in_e164

    # Credit Card Attributes
    request.card_holder      = Faker::Name.name_with_middle
    request.card_number      = Faker::Finance.credit_card
    request.expiration_month = Faker::Date.in_date_period.strftime '%m'
    request.expiration_year  = Faker::Date.in_date_period.strftime '%Y'
    request.cvv              = Faker::Number.positive from: 100, to: 999

    request
  end

  include_examples 'account owner attributes examples'
  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'birth date attributes examples'
  include_examples 'credential on file attributes examples'
  include_examples 'credential on file transaction link excluded examples',
                   %i[credential_on_file credential_on_file_transaction_identifier]
  include_examples 'credit card attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'customer identification attributes examples'
  include_examples 'digital asset type attributes examples'
  include_examples 'document attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'financial attributes examples'
  include_examples 'force threeds excluded examples'
  include_examples 'fx rate attributes examples'
  include_examples 'money transfer payout attributes examples'
  include_examples 'moto attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'purpose of payment attributes examples'
  include_examples 'source of funds attributes examples'
  include_examples 'tokenization attributes examples'

  describe 'excluded credential on file settlement date and scheme tokenized attributes' do
    def excluded_keys
      %i[credential_on_file_settlement_date scheme_tokenized]
    end

    def structure
      request.__send__ :payment_transaction_structure
    end

    def document
      request.build_document
    end

    def xml_elements(name)
      Nokogiri::XML(document).xpath("//#{name}")
    end

    context 'when neither attribute is set' do
      it 'does not have the excluded keys in the structure' do
        excluded_keys.each { |key| expect(structure).to_not have_key(key) }
      end

      it 'keeps the other credential on file and payout keys in the structure' do
        expect(structure.keys).to include(
          :credential_on_file, :credential_on_file_transaction_identifier, :account_owner, :tokenization_params,
          :moto, :crypto, :money_transfer, :billing_address, :shipping_address
        )
      end
    end

    # Values are injected directly into the instance variables, bypassing the setters that raise on Payout, so the
    # exclusion from the structure and the XML is proven even when a value is present
    def inject_settlement_date
      request.instance_variable_set(
        :@credential_on_file_settlement_date,
        GenesisRuby::Utils::Common.parse_date('1231', [GenesisRuby::Api::Constants::DateTimeFormats::MM_DD])
      )
    end

    context 'when credential_on_file_settlement_date is present' do
      before { inject_settlement_date }

      it 'does not have the key in the structure' do
        expect(structure).to_not have_key(:credential_on_file_settlement_date)
      end

      it 'does not include the element in the XML' do
        expect(xml_elements('credential_on_file_settlement_date')).to be_empty
      end
    end

    [true, false].each do |value|
      context "when scheme_tokenized is #{value}" do
        before { request.instance_variable_set(:@scheme_tokenized, value) }

        it 'does not have the key in the structure' do
          expect(structure).to_not have_key(:scheme_tokenized)
        end

        it 'does not include the element in the XML' do
          expect(xml_elements('scheme_tokenized')).to be_empty
        end
      end
    end

    context 'when both attributes are present' do
      before do
        inject_settlement_date
        request.instance_variable_set(:@scheme_tokenized, true)
      end

      it 'does not have the excluded keys in the structure' do
        excluded_keys.each { |key| expect(structure).to_not have_key(key) }
      end

      it 'does not include the excluded elements in the XML' do
        excluded_keys.each { |key| expect(xml_elements(key)).to be_empty }
      end
    end

    context 'when the unsupported setters are used' do
      ['1231', true, false].each do |value|
        it "raises on credential_on_file_settlement_date with #{value.inspect}" do
          expect { request.credential_on_file_settlement_date = value }.to raise_error GenesisRuby::ParameterError
        end

        it "raises on scheme_tokenized with #{value.inspect}" do
          expect { request.scheme_tokenized = value }.to raise_error GenesisRuby::ParameterError
        end
      end
    end

    context 'when the credential_on_file_settlement_date setter error is rescued' do
      before do
        request.credential_on_file_settlement_date = '1231'
      rescue GenesisRuby::ParameterError
        nil
      end

      it 'does not store credential_on_file_settlement_date' do
        expect(request.credential_on_file_settlement_date).to be_nil
      end
    end

    context 'when the scheme_tokenized setter error is rescued' do
      before do
        request.scheme_tokenized = true
      rescue GenesisRuby::ParameterError
        nil
      end

      it 'does not store scheme_tokenized' do
        expect(request.scheme_tokenized).to be_nil
      end
    end

    context 'when the other credential on file attributes are set' do
      let(:credential) { GenesisRuby::Api::Constants::Transactions::Parameters::CredentialOnFiles::MERCHANT_UNSCHEDULED }
      let(:identifier) { 'abcdefghijklmnopqrstuvwxyz123456' }

      before do
        request.credential_on_file                        = credential
        request.credential_on_file_transaction_identifier = identifier
      end

      it 'serializes credential_on_file in the XML' do
        expect(xml_elements('credential_on_file').map(&:text)).to eq [credential]
      end

      it 'serializes credential_on_file_transaction_identifier in the XML' do
        expect(xml_elements('credential_on_file_transaction_identifier').map(&:text)).to eq [identifier]
      end
    end

    it 'keeps the payout transaction type' do
      expect(document).to include('<transaction_type>payout</transaction_type>')
    end
  end

  describe 'when purpose of payment values' do
    it 'with Mastercard money transfer value' do
      request.purpose_of_payment = 'crowd_lending'

      expect(request.build_document).to include '<purpose_of_payment>crowd_lending</purpose_of_payment>'
    end

    it 'with legacy money transfer value' do
      expect { request.purpose_of_payment = 'gift_and_donation' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when gaming attribute removed' do
    it 'does not serialize a gaming node' do
      expect(request.build_document).to_not include '<gaming>'
    end
  end
end
