require 'spec/genesis_ruby/stubs/api/requests/base/financials/south_american_payments_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Financials::SouthAmericanPayments do
  let(:request) do
    request = GenesisSpec::Stubs::Api::Requests::Base::Financials::SouthAmericanPaymentsStub.new config

    request.billing_country = 'BR'

    request
  end

  include_examples 'south american payment examples'
end
