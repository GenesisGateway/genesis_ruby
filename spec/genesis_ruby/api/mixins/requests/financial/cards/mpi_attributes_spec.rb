# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/mpi_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::MpiAttributes do
  let(:mpi) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::MpiAttributesStub.new }

  describe 'when structure' do
    it 'with proper type' do
      expect(mpi.mpi_attributes_structure).to be_kind_of Hash
    end

    it 'with non empty value' do
      expect(mpi.mpi_attributes_structure).to_not be_empty
    end
  end

  describe 'when eci' do
    it 'with setter' do
      expect { mpi.mpi_eci = Faker::Number.positive }.to_not raise_error
    end

    it 'with getter' do
      mpi.mpi_eci = eci = Faker::Number.positive

      expect(mpi.mpi_eci).to eq eci
    end
  end

  describe 'when cavv' do
    it 'with setter' do
      expect { mpi.mpi_cavv = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      mpi.mpi_cavv = cavv = Faker::Internet.uuid

      expect(mpi.mpi_cavv).to eq cavv
    end
  end

  describe 'when protocol version' do
    it 'with valid value' do
      expect do
        mpi.mpi_protocol_version = GenesisRuby::Api::Constants::Transactions::Parameters::MpiProtocolVersions::
            PROTOCOL_VERSION_2
      end.to_not raise_error
    end

    it 'with invalid value' do
      expect { mpi.mpi_protocol_version = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid string value' do
      expect { mpi.mpi_protocol_version = '1' }.to_not raise_error
    end

    it 'with getter' do
      mpi.mpi_protocol_version = mpi_protocol_version = GenesisRuby::Api::Constants::Transactions::Parameters::
          MpiProtocolVersions.all.sample

      expect(mpi.mpi_protocol_version).to eq mpi_protocol_version
    end
  end

  describe 'when directory server id' do
    it 'with setter' do
      expect { mpi.mpi_directory_server_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      mpi.mpi_directory_server_id = server_id = Faker::Internet.uuid

      expect(mpi.mpi_directory_server_id).to eq server_id
    end
  end

  describe 'when asc transaction id' do
    it 'with setter' do
      expect { mpi.mpi_asc_transaction_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      mpi.mpi_asc_transaction_id = transaction_id = Faker::Internet.uuid

      expect(mpi.mpi_asc_transaction_id).to eq transaction_id
    end
  end

  describe 'when threeds challenge indicator' do
    it 'with valid value' do
      expect do
        mpi.mpi_threeds_challenge_indicator = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::
            Version2::Control::ChallengeIndicators::NO_CHALLENGE_REQUESTED
      end.to_not raise_error
    end

    it 'with invalid value' do
      expect do
        mpi.mpi_threeds_challenge_indicator = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with getter' do
      mpi.mpi_threeds_challenge_indicator = challenge_indicator = GenesisRuby::Api::Constants::Transactions::
          Parameters::Threeds::Version2::Control::ChallengeIndicators.all.sample

      expect(mpi.mpi_threeds_challenge_indicator).to eq challenge_indicator
    end
  end

  describe 'when protocol sub version' do
    let(:sub_version) { GenesisRuby::Api::Constants::Transactions::Parameters::MpiProtocolSubVersions.all.sample }

    it 'with valid value' do
      expect { mpi.mpi_protocol_sub_version = sub_version }.to_not raise_error
    end

    it 'with invalid value' do
      expect { mpi.mpi_protocol_sub_version = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid string value' do
      mpi.mpi_protocol_sub_version = sub_version.to_s

      expect(mpi.mpi_protocol_sub_version).to eq sub_version
    end

    it 'with getter' do
      mpi.mpi_protocol_sub_version = sub_version

      expect(mpi.mpi_protocol_sub_version).to eq sub_version
    end

    it 'with integer getter' do
      mpi.mpi_protocol_sub_version = sub_version.to_s

      expect(mpi.mpi_protocol_sub_version).to be_kind_of Integer
    end
  end
end
