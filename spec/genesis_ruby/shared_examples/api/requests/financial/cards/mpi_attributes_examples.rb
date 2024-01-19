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
    end
  end
end
