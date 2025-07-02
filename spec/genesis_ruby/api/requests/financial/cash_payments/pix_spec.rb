# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::CashPayments::Pix do
  let(:skip_customer_phone) { true }
  let(:test_required_fields) { %i[transaction_id amount currency document_id] }
  let(:test_required_field_values) { %i[currency billing_country gender marital_status company_type] }
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

    request.transaction_id  = Faker::Internet.uuid
    request.amount          = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency        = 'EUR'
    request.usage           = Faker::Lorem.sentence
    request.remote_ip       = Faker::Internet.ip_v4_address
    request.document_id     = Faker::Internet.uuid
    request.billing_country = 'BR'

    request
  end

  describe 'when billing country' do
    it 'with optional attribute' do
      request.billing_country = nil

      expect { request.build_document }.to_not raise_error
    end

    it 'with lowercase attribute value' do
      request.billing_country = 'br'

      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when incorporation date' do
    it 'with setter' do
      expect { request.incorporation_date = '23-12-1970' }.to_not raise_error
    end

    it 'with getter' do
      request.incorporation_date = date = Faker::Date.forward.strftime GenesisRuby::Api::Constants::
          DateTimeFormats::DD_MM_YYYY_L_HYPHENS

      expect(request.build_document).to include "<incorporation_date>#{date}</incorporation_date>"
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'beneficiary attributes examples'
  include_examples 'birth date attributes examples'
  include_examples 'document attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'pending attributes examples'
  include_examples 'pix attributes examples'
end
