# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/business_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::BusinessAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::BusinessAttributesStub.new }
  let(:date) do
    Faker::Date.in_date_period.strftime(GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601)
  end

  it 'when business attributes structure' do
    expect(attributes.business_attributes_structure).to be_kind_of Hash
  end

  describe 'when name' do
    it 'with setter' do
      expect { attributes.business_name = Faker::Company.name }.to_not raise_error
    end

    it 'with getter' do
      attributes.business_name = value = Faker::Company.name

      expect(attributes.business_name).to eq value
    end
  end

  describe 'when incorporation_date' do
    it 'with setter' do
      expect { attributes.business_incorporation_date = date }.to_not raise_error
    end

    it 'with getter' do
      attributes.business_incorporation_date = date

      expect(attributes.business_incorporation_date).to eq date
    end

    it 'with invalid value' do
      expect { attributes.business_incorporation_date = 5 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

end
