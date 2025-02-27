require 'spec/genesis_ruby/stubs/api/requests/financial/online_banking_payments/pix_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::OnlineBankingPayments::PixAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::OnlineBankingPayments::PixAttributesStub.new
  end

  describe 'when mothers_name' do
    let(:name) { "#{Faker::Name.female_first_name} #{Faker::Name.last_name}" }

    it 'with getter' do
      attributes.mothers_name = name

      expect(attributes.mothers_name).to eq name
    end

    it 'with setter' do
      expect { attributes.mothers_name = name }.to_not raise_error
    end
  end

  describe 'when company_type' do
    let(:type) { Faker::Lorem.word }

    it 'with getter' do
      attributes.company_type = type

      expect(attributes.company_type).to eq type
    end

    it 'with setter' do
      expect { attributes.company_type = type }.to_not raise_error
    end
  end

  describe 'when company_activity' do
    let(:activity) { Faker::Lorem.word }

    it 'with getter' do
      attributes.company_activity = activity

      expect(attributes.company_activity).to eq activity
    end

    it 'with setter' do
      expect { attributes.company_activity = activity }.to_not raise_error
    end
  end

  describe 'when incorporation_date' do
    let(:date) { '01-01-1970' }

    it 'with getter' do
      attributes.incorporation_date = date

      expect(attributes.incorporation_date).to eq '1970-01-01'
    end

    it 'with setter' do
      expect { attributes.incorporation_date = date }.to_not raise_error
    end

    it 'with invalid_value' do
      expect { attributes.incorporation_date = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with parsed date' do
      attributes.incorporation_date = date

      expect(attributes.instance_variable_get('@incorporation_date')).to be_kind_of DateTime
    end
  end
end
