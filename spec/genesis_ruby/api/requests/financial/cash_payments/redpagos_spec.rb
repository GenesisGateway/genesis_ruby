RSpec.describe GenesisRuby::Api::Requests::Financial::CashPayments::Redpagos do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'UY'

    request
  end

  include_examples 'south american payment examples'
end
