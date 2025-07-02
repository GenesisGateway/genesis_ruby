# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/background_checks_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::BackgroundChecksAttributes do
  let(:attributes)  { GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::BackgroundChecksAttributesStub.new }
  let(:match_score) { Faker::Number.number(digits: 2) }
  let(:date) do
    Faker::Date.between(from: '1950-01-01', to: '2000-12-31')
               .strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
  end
  let(:filters) do
    GenesisRuby::Api::Constants::NonFinancial::Kyc::AmlFilters.all.sample(2)
  end

  it 'when background checks attributes structure' do
    expect(attributes.background_checks_attributes_structure).to be_kind_of Hash
  end

  describe 'when first_name' do
    it 'with setter' do
      expect { attributes.background_checks_first_name = Faker::Name.first_name }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_first_name = value = Faker::Name.first_name

      expect(attributes.background_checks_first_name).to eq value
    end
  end

  describe 'when middle_name' do
    it 'with setter' do
      expect { attributes.background_checks_middle_name = Faker::Name.middle_name }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_middle_name = value = Faker::Name.middle_name

      expect(attributes.background_checks_middle_name).to eq value
    end
  end

  describe 'when last_name' do
    it 'with setter' do
      expect { attributes.background_checks_last_name = Faker::Name.last_name }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_last_name = value = Faker::Name.last_name

      expect(attributes.background_checks_last_name).to eq value
    end
  end

  describe 'when full_name' do
    it 'with setter' do
      expect { attributes.background_checks_full_name = Faker::Name.name }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_full_name = value = Faker::Name.name

      expect(attributes.background_checks_full_name).to eq value
    end
  end

  describe 'when date_of_birth' do
    it 'with setter' do
      expect { attributes.background_checks_date_of_birth = date }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_date_of_birth = date

      expect(attributes.background_checks_date_of_birth).to eq date
    end

    it 'with invalid value' do
      expect { attributes.background_checks_date_of_birth = 5 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when async_update' do
    it 'with setter' do
      expect { attributes.background_checks_async_update = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_async_update = true

      expect(attributes.background_checks_async_update).to eq true
    end

    it 'with invalid value' do
      expect { attributes.background_checks_async_update = 1 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  describe 'when filters' do
    it 'with setter' do
      expect { attributes.background_checks_filters = filters }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_filters = filters

      expect(attributes.background_checks_filters).to eq filters
    end

    it 'with invalid value' do
      expect { attributes.background_checks_filters = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with empty value' do
      expect { attributes.background_checks_filters = [] }.to_not raise_error
    end
  end

  describe 'when match_score' do
    it 'with setter' do
      expect { attributes.background_checks_match_score = match_score }.to_not raise_error
    end

    it 'with getter' do
      attributes.background_checks_match_score = match_score

      expect(attributes.background_checks_match_score).to eq match_score
    end
  end

end
