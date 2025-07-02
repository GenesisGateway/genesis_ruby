# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Notification do
  let(:identifier) { '38d0ad63e7a56a2c6397438d116bafce' }
  let(:signature) { 'd8a6e8108df2224763c8f9fb55f7e23c6cc4454b' }
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  describe 'when invalid notification data' do
    it 'with data without to_h method' do
      notification_data = ''

      expect { described_class.new configuration, notification_data }.to raise_error GenesisRuby::ParameterError
    end

    it 'without unique_id' do
      notification_data = { signature: Faker::Internet.uuid }

      expect { described_class.new configuration, notification_data }.to raise_error GenesisRuby::ParameterError
    end

    it 'without signature' do
      notification_data = { unique_id: Faker::Internet.uuid }

      expect { described_class.new configuration, notification_data }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid signature' do
      notification_data = { unique_id: 'invalid', signature: 'invalid' }

      expect { described_class.new configuration, notification_data }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid transaction reconciliation when reconcile not executed' do
      notification_data = { unique_id: identifier, signature: signature }

      notification_module = described_class.new configuration, notification_data

      expect(notification_module.transaction_reconciliation?).to eq false
    end

    describe 'when reconciliation' do
      let(:notification_module) do
        configuration.token = 'error_reconcile'
        notification_data   = { unique_id: identifier, signature: signature }
        notification_module = described_class.new configuration, notification_data
        notification_module.reconcile

        notification_module
      end

      it 'with invalid transaction reconciliation when request has invalid notification data' do
        expect(notification_module.transaction_reconciliation?).to eq false
      end

      it 'with invalid notification data when XML response' do
        expect(notification_module.reconciliation.response_object)
          .to include(
            code: '220', status: 'error', message: 'Reconcile request failed, please contact support!',
            technical_message: 'Invalid Terminal'
          )
      end
    end
  end

  describe 'when fetch hash type' do
    describe 'with SHA1' do
      let(:signature) { Digest::SHA1.hexdigest "#{identifier}#{configuration.password}" }
      let(:notification_data) { { unique_id: identifier, signature: signature } }
      let(:notification_module) { described_class.new configuration, notification_data }

      it 'with SHA1 signature' do
        expect(notification_module.__send__(:fetch_hash_type)).to eq described_class::SHA1_SIGNATURE_TYPE
      end

      it 'with SHA1 generator' do
        expect(notification_module.__send__(:fetch_signature_generator)).to eq Digest::SHA1
      end
    end

    describe 'with SHA256' do
      let(:signature) { Digest::SHA256.hexdigest "#{identifier}#{configuration.password}" }
      let(:notification_data) { { unique_id: identifier, signature: signature } }
      let(:notification_module) { described_class.new configuration, notification_data }

      it 'with SHA256 signature' do
        expect(notification_module.__send__(:fetch_hash_type)).to eq described_class::SHA256_SIGNATURE_TYPE
      end

      it 'with SHA256 generator' do
        expect(notification_module.__send__(:fetch_signature_generator)).to eq Digest::SHA256
      end
    end

    describe 'with SHA512' do
      let(:signature) { Digest::SHA512.hexdigest "#{identifier}#{configuration.password}" }
      let(:notification_data) { { unique_id: identifier, signature: signature } }
      let(:notification_module) { described_class.new configuration, notification_data }

      it 'with SHA256 signature' do
        expect(notification_module.__send__(:fetch_hash_type)).to eq described_class::SHA512_SIGNATURE_TYPE
      end

      it 'with SHA256 generator' do
        expect(notification_module.__send__(:fetch_signature_generator)).to eq Digest::SHA512
      end
    end
  end

  describe 'when valid notification data' do
    it 'with minimum notification data' do
      notification_data = { unique_id: identifier, signature: signature }

      expect { described_class.new configuration, notification_data }.to_not raise_error
    end

    it 'with normalization' do
      notification_data = { unique_id: identifier, signature: signature, '%27'.to_sym => '%27' }

      expect(described_class.new(configuration, notification_data).notification).to include Hash['\''.to_sym, '\'']
    end

    it 'with normalization when string keys used' do
      notification_data = { 'unique_id' => identifier, 'signature' => signature }

      expect { described_class.new configuration, notification_data }.to_not raise_error
    end

    describe 'when api' do
      let(:notification_data) { { unique_id: identifier, signature: signature } }
      let(:notification_module) { described_class.new configuration, notification_data }

      it 'with api notification' do
        expect(notification_module.api_notification?).to eq true
      end

      it 'with authentic data' do
        expect(notification_module.__send__(:authentic?)).to eq true
      end

      it 'with correct unique_id assignment' do
        expect(notification_module.unique_id).to eq notification_data[:unique_id]
      end

      it 'with correct response' do # rubocop:disable RSpec/ExampleLength
        expect(notification_module.generate_response).to eq <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <notification_echo>
            <unique_id>#{identifier}</unique_id>
          </notification_echo>
        XML
      end

      it 'with reconciliation response object' do
        configuration.token = 'api_transaction'

        expect(notification_module.reconcile).to be_kind_of GenesisRuby::Api::Response
      end

      it 'with valid transaction reconciliation' do
        configuration.token = 'api_transaction'
        notification_module.reconcile

        expect(notification_module.transaction_reconciliation?).to eq true
      end
    end

    describe 'with wpf' do
      let(:notification_data) { { wpf_unique_id: identifier, signature: signature } }
      let(:notification_module) { described_class.new configuration, notification_data }

      it 'with wpf notification' do
        expect(notification_module.wpf_notification?).to eq true
      end

      it 'with authentic data' do
        expect(notification_module.__send__(:authentic?)).to eq true
      end

      it 'with correct unique_id assignment' do
        expect(notification_module.unique_id).to eq notification_data[:wpf_unique_id]
      end

      it 'with correct response' do # rubocop:disable RSpec/ExampleLength
        expect(notification_module.generate_response).to eq <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <notification_echo>
            <wpf_unique_id>#{identifier}</wpf_unique_id>
          </notification_echo>
        XML
      end

      it 'with reconciliation response object' do
        expect(notification_module.reconcile).to be_kind_of GenesisRuby::Api::Response
      end

      it 'with valid transaction reconciliation' do
        notification_module.reconcile

        expect(notification_module.transaction_reconciliation?).to eq true
      end
    end

    describe 'with kyc' do
      let(:notification_data) { { reference_id: identifier, signature: signature } }
      let(:notification_module) { described_class.new configuration, notification_data }

      it 'with kyc notification' do
        expect(notification_module.kyc_notification?).to eq true
      end

      it 'with authentic data' do
        expect(notification_module.__send__(:authentic?)).to eq true
      end

      it 'with correct unique_id assignment' do
        expect(notification_module.unique_id).to eq notification_data[:reference_id]
      end

      it 'with correct response' do # rubocop:disable RSpec/ExampleLength
        expect(notification_module.generate_response).to eq <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <notification_echo>
            <reference_id>#{identifier}</reference_id>
          </notification_echo>
        XML
      end

      it 'with error upon reconcile' do
        expect { notification_module.reconcile }.to raise_error GenesisRuby::ParameterError
      end

      it 'with invalid transaction reconciliation' do
        notification_module.reconcile
      rescue GenesisRuby::Error
        expect(notification_module.transaction_reconciliation?).to eq false
      end
    end
  end
end
