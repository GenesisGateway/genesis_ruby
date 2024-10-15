RSpec.describe GenesisRuby::Api::Requests::Financial::CashPayments::Oxxo do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'MX'

    request
  end

  include_examples 'south american payment examples'
end
