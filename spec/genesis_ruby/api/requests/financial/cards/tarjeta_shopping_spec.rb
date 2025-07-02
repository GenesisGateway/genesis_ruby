# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::TarjetaShopping do
  let(:request) do
    request = described_class.new config

    request.billing_country = 'AR'

    request
  end

  include_examples 'south american payment examples'
end
