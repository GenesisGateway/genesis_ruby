RSpec.describe GenesisRuby::Api::Requests::NonFinancial::ProcessedTransactions::Transaction do
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
    request = described_class.new config
    request.unique_id = Faker::Internet.uuid

    request
  end

  describe 'when invalid request' do
    it 'without attributes' do
      request.unique_id = nil
      request.arn       = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with both attributes' do
      request.arn = Faker::Internet.uuid

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when unique_id' do
    it 'with setter' do
      expect { request.unique_id = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with document element' do
      request.arn = nil

      request.unique_id = identifier = Faker::Internet.uuid

      expect(request.build_document).to include "<unique_id>#{identifier}</unique_id>"
    end
  end

  describe 'when arn' do
    it 'with setter' do
      expect { request.arn = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with document element' do
      request.unique_id = nil

      request.arn = identifier = Faker::Internet.uuid

      expect(request.build_document).to include "<arn>#{identifier}</arn>"
    end
  end

  include_examples 'base request examples'
end
