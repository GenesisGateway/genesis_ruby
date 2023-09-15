require 'spec/genesis_ruby/stubs/api/requests/financial/async_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::AsyncAttributes do
  let(:async_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::AsyncAttributesStub.new }

  describe 'has proper return_success_url accessors' do
    it 'has setter' do
      expect { async_attributes.return_success_url = Faker::Internet.url }.to_not raise_error
    end

    it 'has getter' do
      async_attributes.return_success_url = url = Faker::Internet.url

      expect(async_attributes.return_success_url).to eq(url)
    end
  end

  describe 'has proper return_failure_url accessors' do
    it 'has setter' do
      expect { async_attributes.return_failure_url = Faker::Internet.url }.to_not raise_error
    end

    it 'has getter' do
      async_attributes.return_failure_url = url = Faker::Internet.url

      expect(async_attributes.return_failure_url).to eq(url)
    end
  end

  describe 'has validation' do
    it 'raises with invalid URL when return_success_url' do
      expect do
        async_attributes.return_success_url = Faker::Internet.url(host: '')
      end.to raise_error GenesisRuby::ParameterError
    end

    it 'works with valid URL when return_success_url' do
      expect do
        async_attributes.return_success_url = Faker::Internet.url
      end.to_not raise_error
    end

    it 'raises with invalid URL when return_failure_url' do
      expect do
        async_attributes.return_failure_url = Faker::Internet.url(host: '')
      end.to raise_error GenesisRuby::ParameterError
    end

    it 'works with valid URL when return_failure_url' do
      expect do
        async_attributes.return_failure_url = Faker::Internet.url
      end.to_not raise_error
    end
  end
end
