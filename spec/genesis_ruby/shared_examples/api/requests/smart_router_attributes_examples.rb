# frozen_string_literal: true

RSpec.shared_examples 'smart router attributes examples' do
  describe 'when smart router attributes' do
    let(:url) do
      url = 'reconcile'

      if request.is_a?(GenesisRuby::Api::Requests::Base::Financial) ||
         request.is_a?(GenesisRuby::Api::Requests::Financial::Void)
        url = 'transactions'
      end

      return url
    end

    it 'with force_smart_routing' do
      configuration.force_smart_routing = true

      request.build_document

      expect(request.api_config.url).to eq "https://staging.api.emerchantpay.net:443/#{url}"
    end

    it 'with use_smart_router' do
      configuration.force_smart_routing = false
      request.use_smart_router = true

      request.build_document

      expect(request.api_config.url).to eq "https://staging.api.emerchantpay.net:443/#{url}"
    end
  end
end
