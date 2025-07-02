# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Elo do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'BR'

    request
  end

  include_examples 'south american payment examples'
end
