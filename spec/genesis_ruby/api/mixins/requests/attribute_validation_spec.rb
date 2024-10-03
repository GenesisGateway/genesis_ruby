require 'spec/genesis_ruby/stubs/request_validation'

RSpec.describe GenesisRuby::Api::Mixins::Requests::AttributeValidation do
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request_stub) { GenesisSpec::Stubs::RequestValidation.new configuration }

  describe 'when required attributes' do
    let(:request) do
      request_stub.field3 = 'value2'
      request_stub.field4 = 'value4'

      request_stub
    end

    it 'without required attribute' do
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with required attribute' do
      request.field1 = Faker::Lorem.word

      expect(request.build_document).to include "<field1>#{request.field1}</field1>"
    end
  end

  describe 'when field value attributes' do
    let(:request) do
      request_stub.field1 = Faker::Lorem.word

      request_stub
    end

    it 'without field value attribute' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with valid array field value attribute' do
      request.field3 = 'value3'
      request.field4 = 'value4'

      expect(request.build_document).to include "<field3>#{request.field3}</field3>"
    end

    it 'with invalid array field value attribute' do
      request.field3 = 'invalid'
      request.field4 = 'value4'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with valid single field value attribute' do
      request.field3 = 'value2'
      request.field4 = 'value4'

      expect(request.build_document).to include "<field4>#{request.field4}</field4>"
    end

    it 'with invalid single field value attribute' do
      request.field3 = 'value1'
      request.field4 = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when field value dependencies' do
    let(:request) do
      request_stub.field1 = Faker::Lorem.word

      request_stub
    end

    it 'without required field dependency' do
      request_stub.field5 = 'value1'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with required field dependency' do
      request_stub.field5 = 'value1'
      request_stub.field2 = Faker::Lorem.word

      expect { request.build_document }.to_not raise_error
    end

    it 'without required field value dependency' do
      request_stub.field6 = 'value1'

      expect { request.build_document }.to_not raise_error
    end

    it 'with required field value dependency' do
      request_stub.field6 = 'value1'
      request_stub.field5 = 'value1'
      request_stub.field2 = Faker::Lorem.word

      expect { request.build_document }.to_not raise_error
    end

    it 'without boolean required field value dependency' do
      request.field7 = true

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with boolean required field valued dependency' do
      request.field7 = true
      request.field2 = Faker::Lorem.word

      expect { request.build_document }.to_not raise_error
    end

    it 'with group field requirements' do
      request.field8 = Faker::Lorem.word
      request.field2 = Faker::Lorem.word
      request.field3 = 'value2'

      expect { request.build_document }.to_not raise_error
    end
  end
end
