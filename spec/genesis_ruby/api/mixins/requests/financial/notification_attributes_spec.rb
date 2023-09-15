require 'spec/genesis_ruby/stubs/api/requests/financial/notification_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::NotificationAttributes do
  let(:notification_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::NotificationAttributesStub.new }

  describe 'has proper notification_url accessors' do
    it 'has setter' do
      expect { notification_attributes.notification_url = Faker::Internet.url }.to_not raise_error
    end

    it 'has getter' do
      notification_attributes.notification_url = url = Faker::Internet.url

      expect(notification_attributes.notification_url).to eq(url)
    end
  end

  describe 'has validation' do
    it 'raises with invalid URL' do
      expect do
        notification_attributes.notification_url = Faker::Internet.url(host: '')
      end.to raise_error GenesisRuby::ParameterError
    end

    it 'works with valid URL' do
      expect do
        notification_attributes.notification_url = Faker::Internet.url
      end.to_not raise_error
    end
  end
end
