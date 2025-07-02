# frozen_string_literal: true

RSpec.shared_examples 'mpi attributes examples' do
  describe 'when mpi attributes' do
    describe 'without initialization' do
      it 'without mpi node' do
        expect(request.build_document).to_not include '<mpi_params>'
      end
    end

    describe 'when initialized' do
      let(:mpi) do
        request.mpi_eci                         = Faker::Number.positive
        request.mpi_cavv                        = Faker::Internet.uuid
        request.mpi_protocol_version            = 1
        request.mpi_directory_server_id         = Faker::Internet.uuid
        request.mpi_asc_transaction_id          = Faker::Internet.uuid
        request.mpi_threeds_challenge_indicator = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::
            Version2::Control::ChallengeIndicators.all.sample

        request
      end

      it 'with mpi node' do
        expect(mpi.build_document).to include '<mpi_params>'
      end

      it 'with eci' do
        expect(mpi.build_document).to include "<eci>#{mpi.mpi_eci}</eci>"
      end

      it 'with cavv' do
        expect(mpi.build_document).to include "<cavv>#{mpi.mpi_cavv}</cavv>"
      end

      it 'with protocol version' do
        expect(mpi.build_document).to include "<protocol_version>#{mpi.mpi_protocol_version}</protocol_version>"
      end

      it 'with directory server id' do
        expect(mpi.build_document)
          .to include "<directory_server_id>#{mpi.mpi_directory_server_id}</directory_server_id>"
      end

      it 'with asc transaction id' do
        expect(mpi.build_document).to include "<acs_transaction_id>#{mpi.mpi_asc_transaction_id}</acs_transaction_id>"
      end

      it 'with threeds challenge indicator' do
        challenge_indicator = mpi.mpi_threeds_challenge_indicator

        expect(mpi.build_document)
          .to include "<threeds_challenge_indicator>#{challenge_indicator}</threeds_challenge_indicator>"
      end

      it 'when protocol version 2 with directory server id' do
        mpi.mpi_protocol_version = 2
        mpi.mpi_directory_server_id = Faker::Internet.uuid

        expect { mpi.build_document }.to_not raise_error
      end

      it 'when protocol version 2 without directory server id' do
        mpi.mpi_protocol_version    = 2
        mpi.mpi_directory_server_id = nil
        mpi.scheme_tokenized        = false

        expect { mpi.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'when mpi_protocol_version with scheme_tokenized without mpi_directory_server_id' do
        request.scheme_tokenized        = true
        request.mpi_protocol_version    = 2
        request.mpi_directory_server_id = nil

        expect { request.build_document }.to_not raise_error
      end
    end
  end
end
