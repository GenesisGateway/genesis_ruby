RSpec.shared_examples 'sca attributes examples' do
  let(:exemption) { GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions::AUTH_NETWORK_OUTAGE }
  let(:uuid) { Faker::Internet.uuid }

  describe 'when sca attributes' do
    let(:sca_request) do
      request.sca_exemption        = exemption
      request.sca_visa_merchant_id = uuid

      request
    end

    it 'without sca params' do
      expect(request.build_document).to_not include '<sca_params>'
    end

    it 'with sca params' do
      expect(sca_request.build_document).to include '<sca_params>'
    end

    it 'with sca_exemption' do
      expect(sca_request.build_document).to include "<exemption>#{exemption}</exemption>"
    end

    it 'with sca_visa_merchant_id' do
      expect(sca_request.build_document).to include "<visa_merchant_id>#{uuid}</visa_merchant_id>"
    end
  end
end
