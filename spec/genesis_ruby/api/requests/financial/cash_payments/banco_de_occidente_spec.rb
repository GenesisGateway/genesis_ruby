# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::CashPayments::BancoDeOccidente do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'CO'

    request
  end

  include_examples 'south american payment examples'
end
