require 'spec/genesis_ruby/stubs/api/requests/financial/mobile/google_pay_token_attributes_stub'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Mobile::GooglePayTokenAttributes do
  let(:google_token) { GenesisSpec::Stubs::Api::Requests::Financial::Mobile::GooglePayTokenAttributesStub.new }
  let(:signature) { Base64.encode64 Faker::Internet.uuid }
  let(:signed_key) { Faker::Crypto.sha1 }
  let(:protocol_version) { 'ECv2' }
  let(:message) { Base64.encode64 Faker::Lorem.sentence }
  let(:signatures) { [Base64.encode64(Faker::Internet.uuid), Base64.encode64(Faker::Internet.uuid)] }

  describe 'when token signature' do
    it 'with setter' do
      expect { google_token.token_signature = signature }.to_not raise_error
    end

    it 'with getter' do
      google_token.token_signature = signature

      expect(google_token.token_signature).to eq signature
    end
  end

  describe 'when token signed key' do
    it 'with setter' do
      expect { google_token.token_signed_key = signed_key }.to_not raise_error
    end

    it 'with getter' do
      google_token.token_signed_key = signed_key

      expect(google_token.token_signed_key).to eq signed_key
    end
  end

  describe 'when token protocol version' do
    it 'with setter' do
      expect { google_token.token_protocol_version = protocol_version }.to_not raise_error
    end

    it 'with getter' do
      google_token.token_protocol_version = protocol_version

      expect(google_token.token_protocol_version).to eq protocol_version
    end
  end

  describe 'when token signed message' do
    it 'with setter' do
      expect { google_token.token_signed_message = message }.to_not raise_error
    end

    it 'with getter' do
      google_token.token_signed_message = message

      expect(google_token.token_signed_message).to eq message
    end
  end

  describe 'when token signatures' do
    it 'with setter' do
      expect { google_token.token_signatures = signatures }.to_not raise_error
    end

    it 'with nil value' do
      expect { google_token.token_signatures = nil }.to_not raise_error
    end

    it 'with invalid value' do
      expect { google_token.token_signatures = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      google_token.token_signatures = signatures

      expect(google_token.token_signatures).to eq signatures
    end
  end

  describe 'when token structure' do
    let(:init_google_pay_token) do
      google_token.token_signature        = signature
      google_token.token_protocol_version = protocol_version
      google_token.token_signed_message   = message
      google_token.token_signed_key       = signed_key
      google_token.token_signatures       = signatures
    end
    let(:structure) do
      {
        signature:              signature,
        protocolVersion:        protocol_version,
        signedMessage:          message,
        intermediateSigningKey: { signedKey:  signed_key, signatures: signatures }
      }
    end

    it 'with string structure' do
      init_google_pay_token

      expect(google_token.google_pay_token_structure).to be_kind_of String
    end

    it 'with proper structure' do
      init_google_pay_token

      expect(google_token.google_pay_token_structure).to eq structure.to_json
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
