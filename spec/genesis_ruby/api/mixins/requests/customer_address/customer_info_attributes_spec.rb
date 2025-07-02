# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/customer_address/customer_info_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::CustomerAddress::CustomerInfoAttributes do
  let(:customer_attributes) { GenesisSpec::Stubs::Api::Requests::CustomerAddress::CustomerInfoAttributesStub.new }

  describe 'has proper customer_email accessors' do
    it 'has setter' do
      expect { customer_attributes.customer_email = Faker::Internet.email }.to_not raise_error
    end

    it 'has getter' do
      customer_attributes.customer_email = email = Faker::Internet.email

      expect(customer_attributes.customer_email).to eq(email)
    end
  end

  describe 'has proper customer_phone accessors' do
    it 'has setter' do
      expect { customer_attributes.customer_phone = Faker::PhoneNumber.cell_phone }.to_not raise_error
    end

    it 'has getter' do
      customer_attributes.customer_phone = phone = Faker::PhoneNumber.cell_phone

      expect(customer_attributes.customer_phone).to eq(phone)
    end
  end

  describe 'with valid email' do
    it 'allow accented characters' do
      expect { customer_attributes.customer_email = 'àèìòùÀÈÌÒÙér@subdomain.domain.com' }.to_not raise_error
    end

    it 'allow apostrophe characters' do
      expect { customer_attributes.customer_email = 'áéíóúýÁÉÍÓÚÝ@subdomain.domain.com' }.to_not raise_error
    end

    it 'allow caret characters' do
      expect { customer_attributes.customer_email = 'âêîôûÂÊÎÔÛ@subdomain.domain.com' }.to_not raise_error
    end

    it 'allow tilde characters' do
      expect { customer_attributes.customer_email = 'ãñõÃÑÕ@subdomain.domain.com' }.to_not raise_error
    end
  end

  describe 'with invalid email' do
    it 'raise error' do
      expect { customer_attributes.customer_email = 'invalid' }.to raise_error GenesisRuby::ParameterError
    end
  end
end
