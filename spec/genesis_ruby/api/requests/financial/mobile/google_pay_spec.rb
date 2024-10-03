RSpec.describe GenesisRuby::Api::Requests::Financial::Mobile::GooglePay do
  let(:test_required_fields) do
    %i[
      transaction_id
      payment_subtype
      amount
      currency
      token_signature
      token_signed_key
      token_signatures
      token_protocol_version
      token_signed_message
    ]
  end
  let(:test_required_field_values) do
    %i[
      currency
      payment_subtype
      threeds_v2_control_device_type
      threeds_v2_control_challenge_window_size
      threeds_v2_control_challenge_indicator
      threeds_v2_purchase_category
      threeds_v2_merchant_risk_shipping_indicator
      threeds_v2_merchant_risk_delivery_timeframe
      threeds_v2_merchant_risk_reorder_items_indicator
      threeds_v2_merchant_risk_pre_order_purchase_indicator
      threeds_v2_merchant_risk_gift_card
      threeds_v2_card_holder_account_update_indicator
      threeds_v2_card_holder_account_password_change_indicator
      threeds_v2_card_holder_account_shipping_address_usage_indicator
      threeds_v2_card_holder_account_suspicious_activity_indicator
      threeds_v2_card_holder_account_registration_indicator
      threeds_v2_browser_color_depth
      threeds_v2_browser_java_enabled
      threeds_v2_sdk_interface
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
  let(:sample_data) { Faker::Lorem.word }
  let(:request) do
    request = described_class.new config

    request.transaction_id               = Faker::Internet.uuid
    request.amount                       = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency                     = 'EUR'
    request.usage                        = Faker::Lorem.sentence
    request.remote_ip                    = Faker::Internet.ip_v4_address
    request.payment_subtype              = GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::GooglePay::
        PaymentSubtypes.all.sample

    request.token_protocol_version = 'ECv2'
    request.token_signature        = sample_data
    request.token_signatures       = [sample_data]
    request.token_signed_key       = sample_data
    request.token_signed_message   = sample_data

    request
  end

  describe 'when Google Pay request with payment token from accessors' do
    it 'with token_protocol_version' do
      expect(request.build_document).to include '"protocolVersion":"ECv2"'
    end

    it 'with token_signature' do
      expect(request.build_document).to include "\"signature\":\"#{sample_data}\""
    end

    it 'with token_signed_key' do
      expect(request.build_document).to include "\"signedKey\":\"#{sample_data}\""
    end

    it 'with token_signed_message' do
      expect(request.build_document).to include "\"signedMessage\":\"#{sample_data}\""
    end

    it 'with token_signatures' do
      expect(request.build_document).to include "\"signatures\":[\"#{sample_data}\"]"
    end
  end

  describe 'when Google Pay request with payment token from JSON string' do
    let(:request) do
      request = described_class.new config

      request.transaction_id               = Faker::Internet.uuid
      request.amount                       = Faker::Number.decimal l_digits: 2, r_digits: 2
      request.currency                     = 'EUR'
      request.usage                        = Faker::Lorem.sentence
      request.remote_ip                    = Faker::Internet.ip_v4_address
      request.payment_subtype              = GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::GooglePay::
          PaymentSubtypes.all.sample

      # rubocop:disable Layout/LineLength
      request.json_token = '{
        "protocolVersion":"ECv2",
        "signature":"MEQCIH6Q4OwQ0jAceFEkGF0JID6sJNXxOEi4r+mA7biRxqBQAiAondqoUpU/bdsrAOpZIsrHQS9nwiiNwOrr24RyPeHA0Q\u003d\u003d",
        "intermediateSigningKey":{
          "signedKey": "{\"keyExpiration\":\"1542323393147\",\"keyValue\":\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE/1+3HBVSbdv+j7NaArdgMyoSAM43yRydzqdg1TxodSzA96Dj4Mc1EiKroxxunavVIvdxGnJeFViTzFvzFRxyCw\\u003d\\u003d\"}",
          "signatures": ["MEYCIQCO2EIi48s8VTH+ilMEpoXLFfkxAwHjfPSCVED/QDSHmQIhALLJmrUlNAY8hDQRV/y1iKZGsWpeNmIP+z+tCQHQxP0v"]
        },
        "signedMessage":"{\"tag\":\"jpGz1F1Bcoi/fCNxI9n7Qrsw7i7KHrGtTf3NrRclt+U\\u003d\",\"ephemeralPublicKey\":\"BJatyFvFPPD21l8/uLP46Ta1hsKHndf8Z+tAgk+DEPQgYTkhHy19cF3h/bXs0tWTmZtnNm+vlVrKbRU9K8+7cZs\\u003d\",\"encryptedMessage\":\"mKOoXwi8OavZ\"}"
      }'
      # rubocop:enable Layout/LineLength

      request
    end

    it 'with protocol version' do
      expect(request.build_document).to include '"protocolVersion":"ECv2"'
    end

    it 'with signature' do
      expect(request.build_document).to include '"signature":"MEQCIH6Q4OwQ0jAceFEkGF0JID6sJNXxOEi4r+mA7biRxqBQAiAo' \
                                                  'ndqoUpU/bdsrAOpZIsrHQS9nwiiNwOrr24RyPeHA0Q=="'
    end

    it 'with signed key' do
      expect(request.build_document).to include '"signedKey":"{\"keyExpiration\":\"1542323393147\",\"keyValue\":\"MFk' \
                                                  'wEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE/1+3HBVSbdv+j7NaArdgMyoSAM43yRydz' \
                                                  'qdg1TxodSzA96Dj4Mc1EiKroxxunavVIvdxGnJeFViTzFvzFRxyCw==\"}"'
    end

    it 'with signatures' do
      expect(request.build_document).to include '"signatures":["MEYCIQCO2EIi48s8VTH+ilMEpoXLFfkxAwHjfPSCVED/QDSHmQIhA' \
                                                  'LLJmrUlNAY8hDQRV/y1iKZGsWpeNmIP+z+tCQHQxP0v"]'
    end

    it 'with signed message' do
      expect(request.build_document).to include '"signedMessage":"{\"tag\":\"jpGz1F1Bcoi/fCNxI9n7Qrsw7i7KHrGtTf3NrRc' \
                                                  'lt+U=\",\"ephemeralPublicKey\":\"BJatyFvFPPD21l8/uLP46Ta1hsKHndf8' \
                                                  'Z+tAgk+DEPQgYTkhHy19cF3h/bXs0tWTmZtnNm+vlVrKbRU9K8+7cZs=\",\"encr' \
                                                  'yptedMessage\":\"mKOoXwi8OavZ\"}"'
    end

  end

  include_examples 'base request examples'
  include_examples 'address info attributes examples'
  include_examples 'document attributes examples'
  include_examples 'async attributes examples'
  include_examples 'birth date attributes examples'
  include_examples 'business attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'notification attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'threeds v2 common attributes examples'
  include_examples 'card holder date attributes examples'
end
