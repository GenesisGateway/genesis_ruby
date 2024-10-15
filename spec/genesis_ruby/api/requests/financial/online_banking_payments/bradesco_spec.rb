RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Bradesco do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'BR'

    request
  end

  include_examples 'south american payment examples'
  include_examples 'pending attributes examples'
end
