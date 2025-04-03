require 'spec/genesis_ruby/stubs/api/requests/base/graphql_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Graphql do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING
    configuration.token       = '123'

    configuration
  end

  it 'when base class without implementation' do
    expect { described_class.new configuration }.to raise_error NoMethodError
  end

  it 'when implemented with structure sanitization' do
    graphql = GenesisSpec::Stubs::Api::Requests::Base::GraphqlStub.new configuration

    expect(graphql.build_document).to eq "query {\n  billingTransactions()\n  {\n\n  }\n}"
  end

  describe 'when implemented' do
    let(:request) do
      request = GenesisSpec::Stubs::Api::Requests::Base::GraphqlStub.new configuration
      request.start_date         = '2023-10-03'
      request.end_date           = '2023-10-05'
      request.transaction_type   = ['Settlement Approved']
      request.billing_statement  = %w(A123 B456)
      request.page               = 2
      request.per_page           = 3
      request.order_by_direction = 'desc'
      request.order_by_field     = 'transactionDate'
      request.items              = %w(billingStatement uniqueId transactionType billingAmount billingCurrency
                                      transactionDate)
      request.paging             = %w(page perPage pagesCount totalCount)

      request
    end

    it 'with proper format' do
      expect(request.api_config.format).to eq 'graphql'
    end

    it 'with proper endpoint' do
      expect(request.api_config.url).to eq 'https://staging.api.emerchantpay.net:443/billing_transactions/v1/graphql'
    end

    it 'with proper document' do
      document = File.open("#{File.dirname(__FILE__)}/../../../fixtures/requests/billing_api_request.gql")
                     .read.strip

      expect(request.build_document).to eq document
    end

    include_examples 'base request examples'
    include_examples 'graphql request examples'
    include_examples 'versioned request examples'
  end
end
