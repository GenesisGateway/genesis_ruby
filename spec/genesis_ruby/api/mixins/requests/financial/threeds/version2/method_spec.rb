# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/method_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Method  do
  let(:method) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::MethodStub.new
  end

  describe 'when threeds_v2_method_callback_url' do
    it 'with valid url' do
      method.threeds_v2_method_callback_url = url = Faker::Internet.url

      expect(method.threeds_v2_method_callback_url).to eq(url)
    end

    it 'with empty url' do
      method.threeds_v2_method_callback_url = ''

      expect(method.threeds_v2_method_callback_url).to eq(nil)
    end

    it 'with invalid url' do
      expect do
        method.threeds_v2_method_callback_url = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(method.method_attributes).to_not be_empty
  end

end
