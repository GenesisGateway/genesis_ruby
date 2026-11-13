# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Wallets::EWallet do
  let(:test_required_fields) { %i[transaction_id payment_type amount currency billing_country] }
  let(:test_required_field_values) { %i[currency payment_type] }
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
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'INR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone
    request.billing_country    = 'IN'
    request.payment_type       = GenesisRuby::Api::Constants::Transactions::Parameters::Wallets::EWallet::
        PaymentTypes.all.sample

    request
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'

  describe 'when payment_type' do
    GenesisRuby::Api::Constants::Transactions::Parameters::Wallets::EWallet::
        PaymentTypes.all.each do |payment_type|
      it "builds with #{payment_type} payment type" do
        request.payment_type = payment_type

        expect(request.build_document).to include "<payment_type>#{payment_type}</payment_type>"
      end
    end

    it 'raises with invalid case payment type' do
      request.payment_type = 'paytm'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when currency' do
    it 'raises with non INR currency' do
      request.currency = 'EUR'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'builds with lower-case INR currency' do
      request.currency = 'inr'

      expect(request.build_document).to include '<currency>INR</currency>'
    end
  end

  describe 'when return urls' do
    it 'raises with invalid return_success_url' do
      expect { request.return_success_url = 'invalid' }.to raise_error GenesisRuby::ParameterError
    end

    it 'raises with invalid return_failure_url' do
      expect { request.return_failure_url = 'invalid' }.to raise_error GenesisRuby::ParameterError
    end

    it 'raises without return_success_url' do # rubocop:disable RSpec/ExampleLength
      ewallet = described_class.new config
      ewallet.transaction_id     = Faker::Internet.uuid
      ewallet.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
      ewallet.currency           = 'INR'
      ewallet.billing_country    = 'IN'
      ewallet.return_failure_url = Faker::Internet.url
      ewallet.payment_type       = GenesisRuby::Api::Constants::Transactions::Parameters::Wallets::EWallet::
          PaymentTypes::PAYTM

      expect { ewallet.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'raises without return_failure_url' do # rubocop:disable RSpec/ExampleLength
      ewallet = described_class.new config
      ewallet.transaction_id     = Faker::Internet.uuid
      ewallet.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
      ewallet.currency           = 'INR'
      ewallet.billing_country    = 'IN'
      ewallet.return_success_url = Faker::Internet.url
      ewallet.payment_type       = GenesisRuby::Api::Constants::Transactions::Parameters::Wallets::EWallet::
          PaymentTypes::PAYTM

      expect { ewallet.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when conditionally required fields' do
    it 'builds without conditionally required fields' do
      request.remote_ip      = nil
      request.customer_email = nil
      request.customer_phone = nil

      expect { request.build_document }.to_not raise_error
    end

    it 'raises with malformed customer_email' do
      expect { request.customer_email = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when building document' do
    it 'with transaction type' do
      expect(request.build_document).to include '<transaction_type>e_wallet</transaction_type>'
    end

    it 'without shipping address' do
      expect(request.build_document).to_not include '<shipping_address>'
    end

    it 'with full document' do # rubocop:disable RSpec/ExampleLength
      request.transaction_id       = '119643250547501c79d8295'
      request.usage                = '40208 concert tickets'
      request.remote_ip            = '245.253.2.12'
      request.amount               = '500.00'
      request.currency             = 'INR'
      request.payment_type         = GenesisRuby::Api::Constants::Transactions::Parameters::Wallets::EWallet::
          PaymentTypes::FREE_CHARGE
      request.return_success_url   = 'https://www.example.com/success'
      request.return_failure_url   = 'https://www.example.com/failure'
      request.customer_email       = 'travis@example.com'
      request.customer_phone       = '+919876543210'
      request.billing_first_name   = 'Travis'
      request.billing_last_name    = 'Pastrana'
      request.billing_address1     = 'Muster Str. 12'
      request.billing_address2     = 'Flat 4'
      request.billing_zip_code     = '400001'
      request.billing_city         = 'Mumbai'
      request.billing_state        = 'MH'
      request.billing_neighborhood = 'Colaba'
      request.billing_country      = 'IN'

      expect(request.build_document).to eq <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <payment_transaction>
          <transaction_type>e_wallet</transaction_type>
          <transaction_id>119643250547501c79d8295</transaction_id>
          <usage>40208 concert tickets</usage>
          <remote_ip>245.253.2.12</remote_ip>
          <amount>50000</amount>
          <currency>INR</currency>
          <payment_type>Free Charge</payment_type>
          <return_success_url>https://www.example.com/success</return_success_url>
          <return_failure_url>https://www.example.com/failure</return_failure_url>
          <customer_email>travis@example.com</customer_email>
          <customer_phone>+919876543210</customer_phone>
          <billing_address>
            <first_name>Travis</first_name>
            <last_name>Pastrana</last_name>
            <address1>Muster Str. 12</address1>
            <address2>Flat 4</address2>
            <zip_code>400001</zip_code>
            <city>Mumbai</city>
            <state>MH</state>
            <neighborhood>Colaba</neighborhood>
            <country>IN</country>
          </billing_address>
        </payment_transaction>
      XML
    end
  end

  describe 'when billing state' do
    it 'raises without billing state for US' do
      request.billing_country = 'US'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'raises without billing state for CA' do
      request.billing_country = 'CA'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'raises without billing state for lower-case us' do
      request.billing_country = 'us'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'builds with billing state for US' do
      request.billing_country = 'US'
      request.billing_state   = 'NY'

      expect { request.build_document }.to_not raise_error
    end

    it 'builds with billing state for CA' do
      request.billing_country = 'CA'
      request.billing_state   = 'ON'

      expect { request.build_document }.to_not raise_error
    end

    it 'builds without billing state for IN' do
      expect { request.build_document }.to_not raise_error
    end

    it 'emits upper-cased billing country' do
      request.billing_country = 'in'

      expect(request.build_document).to include '<country>IN</country>'
    end
  end
end
