RSpec.describe GenesisRuby::Api::Requests::Financial::Mobile::ApplePay do
  let(:test_required_fields) do
    %i[transaction_id
       payment_subtype
       token_version
       token_data
       token_signature
       token_ephemeral_public_key
       token_public_key_hash
       token_transaction_id
       token_display_name
       token_network
       token_type
       token_transaction_identifier
       amount
       currency]
  end
  let(:test_required_field_values) { %i[currency payment_subtype] }

  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) { Faker::Lorem.word }

  let(:request) do
    request = described_class.new config

    request.transaction_id               = Faker::Internet.uuid
    request.amount                       = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency                     = 'EUR'
    request.usage                        = Faker::Lorem.sentence
    request.remote_ip                    = Faker::Internet.ip_v4_address
    request.payment_subtype              = GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::ApplePay::
        PaymentSubtypes.all.sample

    # Payment Token attributes
    request.token_version                = 'ECv2'
    request.token_data                   = sample_data
    request.token_signature              = sample_data
    request.token_ephemeral_public_key   = sample_data
    request.token_public_key_hash        = sample_data
    request.token_transaction_identifier = sample_data
    request.token_transaction_id         = sample_data
    request.token_display_name           = sample_data
    request.token_network                = sample_data
    request.token_application_data       = sample_data
    request.token_type                   = sample_data
    request.token_wrapped_key            = sample_data

    request
  end

  describe 'when Apple Pay request with payment token from accessors' do
    it 'with token_version' do
      expect(request.build_document).to include '"version":"ECv2"'
    end

    it 'with token_signature' do
      expect(request.build_document).to include "\"signature\":\"#{sample_data}\""
    end

    it 'with token_ephemeral_token_public_key' do
      expect(request.build_document).to include "\"ephemeralPublicKey\":\"#{sample_data}\""
    end

    it 'with token_public_key_hash' do
      expect(request.build_document).to include "\"publicKeyHash\":\"#{sample_data}\""
    end

    it 'with token_transaction_identifier' do
      expect(request.build_document).to include "\"transactionIdentifier\":\"#{sample_data}\""
    end

    it 'with token_transaction_id' do
      expect(request.build_document).to include "\"transactionId\":\"#{sample_data}\""
    end

    it 'with token_display_name' do
      expect(request.build_document).to include "\"displayName\":\"#{sample_data}\""
    end

    it 'with token_network' do
      expect(request.build_document).to include "\"network\":\"#{sample_data}\""
    end

    it 'with token_application_data' do
      expect(request.build_document).to include "\"applicationData\":\"#{sample_data}\""
    end

    it 'with token_type' do
      expect(request.build_document).to include "\"type\":\"#{sample_data}\""
    end

    it 'with token_wrapped_key' do
      expect(request.build_document).to include "\"wrappedKey\":\"#{sample_data}\""
    end
  end

  describe 'when Apple Pay request with payment token from json string' do
    let(:request) do
      request = described_class.new config

      request.transaction_id               = Faker::Internet.uuid
      request.amount                       = Faker::Number.decimal l_digits: 2, r_digits: 2
      request.currency                     = 'EUR'
      request.usage                        = Faker::Lorem.sentence
      request.remote_ip                    = Faker::Internet.ip_v4_address
      request.payment_subtype              = GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::ApplePay::
          PaymentSubtypes.all.sample

      request.json_token = '{"paymentData":{' \
                              '"version":"EC_v1",' \
                              '"data":"data",' \
                              '"signature":"signature",' \
                              '"publicKeyHash":"QOmvMaoCNYk5tv+69KC1i2UCFQcOl6LYPIJfYAT+SLQ=",' \
                              '"transactionId":"ccedaf3f32efcc971259694f0efd0dcaa0ed545e7a31a0f7ec8e1c110656c25b",' \
                              '"header":{' \
                                '"wrappedKey": "wrapped key",' \
                                '"ephemeralPublicKey":"public_key",' \
                                '"publicKeyHash":"QOmvMaoCNYk5tv+69KC1i2UCFQcOl6LYPIJfYAT+SLQ=",' \
                                '"transactionId":"ccedaf3f32efcc971259694f0efd0dcaa0ed545e7a31a0f7ec8e1c110656c25b"' \
                            '}},' \
                            '"paymentMethod":{' \
                              '"displayName":"Visa 0225",' \
                              '"network":"Visa",' \
                              '"type":"debit"},' \
                            '"transactionIdentifier":"CCEDAF3F32EFCC971259694F0EFD0DCAA0ED545E7A31A0F7EC8E1C110656"}'

      request
    end

    it 'with token_version' do
      expect(request.build_document).to include '"version":"EC_v1"'
    end

    it 'with token_signature' do
      expect(request.build_document).to include 'signature":"signature"'
    end

    it 'with token_ephemeral_token_public_key' do
      expect(request.build_document).to include '"ephemeralPublicKey":"public_key"'
    end

    it 'with token_public_key_hash' do
      expect(request.build_document).to include '"publicKeyHash":"QOmvMaoCNYk5tv+69KC1i2UCFQcOl6LYPIJfYAT+SLQ="'
    end

    it 'with token_transaction_identifier' do
      expect(request.build_document)
        .to include 'transactionIdentifier":"CCEDAF3F32EFCC971259694F0EFD0DCAA0ED545E7A31A0F7EC8E1C110656"'
    end

    it 'with token_transaction_id' do
      expect(request.build_document)
        .to include '"transactionId":"ccedaf3f32efcc971259694f0efd0dcaa0ed545e7a31a0f7ec8e1c110656c25b"'
    end

    it 'with token_display_name' do
      expect(request.build_document).to include '"displayName":"Visa 0225"'
    end

    it 'with token_network' do
      expect(request.build_document).to include '"network":"Visa"'
    end

    it 'with token_type' do
      expect(request.build_document).to include '"type":"debit"'
    end

    it 'with token_wrapped_key' do
      expect(request.build_document).to include '"wrappedKey":"wrapped key"'
    end

    it 'with sanitized payment_token_structure' do
      expect(request.build_document).to_not include 'applicationData'
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'birth date attributes examples'
  include_examples 'business attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'document attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'financial attributes examples'
  include_examples 'funding attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'recurring type mobile tokenized examples'
end
