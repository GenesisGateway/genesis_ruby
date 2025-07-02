# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/mobile/apple_pay_token_attributes_stub'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Mobile::ApplePayTokenAttributes do
  let(:apple_pay_token) { GenesisSpec::Stubs::Api::Requests::Financial::Mobile::ApplePayTokenAttributesStub.new }
  let(:version) { 'EC_v1' }
  let(:token_data) { Base64.encode64(Faker::Crypto.sha512) }
  let(:signature) { 'MEQCIH6Q4OwQ0jAceFEkGF0JID6sJNXxOEi4r+mA7biRxqBQAiAondqoUpU/bdsrAOpZIsrHQS9nwiiNwOrr24RyPeHA0Q==' }
  let(:ephemeral_public_key) { Faker::Crypto.sha512 }
  let(:hash) { Faker::Crypto.sha256 }
  let(:identifier) { Faker::Internet.uuid }
  let(:display_name) { Faker::Lorem.word }
  let(:network) { Faker::Lorem.word }
  let(:type) { Faker::Lorem.word }
  let(:data) { Faker::Crypto.sha256 }
  let(:key) { Base64.encode64(Faker::Internet.uuid) }

  describe 'when token version' do
    it 'with setter' do
      expect { apple_pay_token.token_version = version }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_version = version

      expect(apple_pay_token.token_version).to eq version
    end
  end

  describe 'when token data' do
    it 'with setter' do
      expect { apple_pay_token.token_data = token_data }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_data = token_data

      expect(apple_pay_token.token_data).to eq token_data
    end
  end

  describe 'when token signature' do
    it 'with setter' do
      expect { apple_pay_token.token_signature }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_signature = signature

      expect(apple_pay_token.token_signature).to eq signature
    end
  end

  describe 'when token ephemeral public key' do
    it 'with setter' do
      expect { apple_pay_token.token_ephemeral_public_key = ephemeral_public_key }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_ephemeral_public_key = ephemeral_public_key

      expect(apple_pay_token.token_ephemeral_public_key).to eq ephemeral_public_key
    end
  end

  describe 'when token public key hash' do
    it 'with setter' do
      expect { apple_pay_token.token_public_key_hash = hash }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_public_key_hash = hash

      expect(apple_pay_token.token_public_key_hash = hash).to eq hash
    end
  end

  describe 'when token transaction id' do
    it 'with setter' do
      expect { apple_pay_token.token_transaction_id = identifier }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_transaction_id = identifier

      expect(apple_pay_token.token_transaction_id = identifier).to eq identifier
    end
  end

  describe 'when token display name' do
    it 'with setter' do
      expect { apple_pay_token.token_display_name = display_name }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_display_name = display_name

      expect(apple_pay_token.token_display_name).to eq display_name
    end
  end

  describe 'when token network' do
    it 'with setter' do
      expect { apple_pay_token.token_network = network }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_network = network

      expect(apple_pay_token.token_network).to eq network
    end
  end

  describe 'when token type' do
    it 'with setter' do
      expect { apple_pay_token.token_type = type }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_type = type

      expect(apple_pay_token.token_type).to eq type
    end
  end

  describe 'when token transaction identifier' do
    it 'with setter' do
      expect { apple_pay_token.token_transaction_identifier = identifier }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_transaction_identifier = identifier

      expect(apple_pay_token.token_transaction_identifier).to eq identifier
    end
  end

  describe 'when token application data' do
    it 'with setter' do
      expect { apple_pay_token.token_application_data = data }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_application_data = data

      expect(apple_pay_token.token_application_data = data).to eq data
    end
  end

  describe 'when token wrapped key' do
    it 'with setter' do
      expect { apple_pay_token.token_wrapped_key = key }.to_not raise_error
    end

    it 'with getter' do
      apple_pay_token.token_wrapped_key = key

      expect(apple_pay_token.token_wrapped_key = key).to eq key
    end
  end

  describe 'when token structure' do
    let(:init_apple_pay_token) do
      apple_pay_token.token_version                = version
      apple_pay_token.token_data                   = token_data
      apple_pay_token.token_signature              = signature
      apple_pay_token.token_ephemeral_public_key   = ephemeral_public_key
      apple_pay_token.token_public_key_hash        = hash
      apple_pay_token.token_transaction_id         = identifier
      apple_pay_token.token_display_name           = display_name
      apple_pay_token.token_network                = network
      apple_pay_token.token_type                   = type
      apple_pay_token.token_transaction_identifier = identifier
      apple_pay_token.token_application_data       = data
      apple_pay_token.token_wrapped_key            = key
    end
    let(:structure) do
      {
        paymentData:           {
          version:   version,
          data:      token_data,
          signature: signature,
          header:    {
            applicationData:    data,
            ephemeralPublicKey: ephemeral_public_key,
            wrappedKey:         key,
            publicKeyHash:      hash,
            transactionId:      identifier
          }
        },
        paymentMethod:         {
          displayName: display_name,
          network:     network,
          type:        type
        },
        transactionIdentifier: identifier
      }
    end

    before do
      init_apple_pay_token
    end

    it 'with string structure' do
      expect(apple_pay_token.payment_token_structure).to be_kind_of String
    end

    it 'with proper structure' do
      expect(apple_pay_token.payment_token_structure).to eq structure.to_json
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
