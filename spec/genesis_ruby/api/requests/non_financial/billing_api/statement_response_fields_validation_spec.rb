# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::BillingApi::Statement do
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) do
    request          = described_class.new config
    request.currency = 'EUR'

    request
  end

  describe 'when top-level response-field validation' do
    context 'with an invalid top-level field' do
      before { request.response_fields = %w(notARealField) }

      it 'raises a parameter error' do
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'names the invalid field in the error message' do
        expect { request.build_document }
          .to raise_error GenesisRuby::ParameterError, /notARealField/
      end

      it 'emits no query (the raise happens before any output)' do # rubocop:disable RSpec/MultipleExpectations
        document = nil

        expect { document = request.build_document }.to raise_error GenesisRuby::ParameterError
        expect(document).to be_nil
      end
    end

    context 'with a nested (non-top-level) name' do
      before { request.response_fields = ['id', { 'summary' => %w(anythingGoesHere evenThis) }] }

      it 'does not validate the nested names and builds successfully' do # rubocop:disable RSpec/MultipleExpectations
        document = request.build_document

        expect(document).to include 'anythingGoesHere'
        expect(document).to include 'evenThis'
      end
    end

    context 'with case-sensitive exact matching' do
      it "rejects a name differing only in case ('ID')" do
        request.response_fields = %w(ID)

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /ID/
      end

      it "rejects a name differing only in case ('Id')" do
        request.response_fields = %w(Id)

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /Id/
      end

      it "rejects a name with leading whitespace (' id')" do
        request.response_fields = [' id']

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it "rejects a name with trailing whitespace ('id ')" do
        request.response_fields = ['id ']

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it "accepts the exact name ('id')" do
        request.response_fields = %w(id)

        expect(request.build_document).to include 'id'
      end
    end
  end
end
