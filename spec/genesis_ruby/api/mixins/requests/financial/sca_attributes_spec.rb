# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/sca_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::ScaAttributes do
  let(:sca_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::ScaAttributesStub.new }

  it 'when sca attributes structure' do
    expect(sca_attributes.sca_attributes_structure).to be_kind_of Hash
  end

  describe 'when sca_exemption accessors' do
    describe 'when valid values' do
      it 'with setter' do
        expect do
          sca_attributes.sca_exemption = GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions::
            AUTH_NETWORK_OUTAGE
        end.to_not raise_error
      end

      it 'with getter' do
        sca_attributes.sca_exemption = exemption = GenesisRuby::Api::Constants::Transactions::Parameters::
            ScaExemptions::DELEGATED_AUTHENTICATION

        expect(sca_attributes.sca_exemption).to eq exemption
      end
    end

    describe 'when invalid values' do
      it 'with error when invalid exemption' do
        expect { sca_attributes.sca_exemption = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end

  describe 'when sca_visa_merchant_id' do
    it 'with setter' do
      expect { sca_attributes.sca_visa_merchant_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      sca_attributes.sca_visa_merchant_id = identifier = Faker::Internet.uuid

      expect(sca_attributes.sca_visa_merchant_id).to eq identifier
    end
  end
end
