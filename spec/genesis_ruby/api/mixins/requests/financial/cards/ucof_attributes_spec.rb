require 'spec/genesis_ruby/stubs/api/requests/financial/cards/ucof_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::UcofAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::UcofAttributesStub.new }

  describe 'when credential_on_file_transaction_identifier' do
    let(:identifier) { Faker::Internet.uuid[..31] }

    describe 'when valid values' do
      it 'with getter' do
        attributes.credential_on_file_transaction_identifier = identifier

        expect(attributes.credential_on_file_transaction_identifier).to eq identifier
      end

      it 'with setter' do
        expect { attributes.credential_on_file_transaction_identifier = identifier }.to_not raise_error
      end
    end

    describe 'when invalid values' do
      it 'with minimum invalid value' do
        expect { attributes.credential_on_file_transaction_identifier = identifier[..13] }
          .to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with maximin invalid value' do
        expect { attributes.credential_on_file_transaction_identifier = "#{identifier}1" }
          .to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end

  describe 'when credential_on_file_settlement_date' do
    describe 'when valid values' do
      it 'with getter' do
        attributes.credential_on_file_settlement_date = '1231'

        expect(attributes.credential_on_file_settlement_date).to eq '1231'
      end

      it 'with setter' do
        expect { attributes.credential_on_file_settlement_date = '1231' }.to_not raise_error
      end

      it 'with full date string' do
        attributes.credential_on_file_settlement_date = '1970-02-01'

        expect(attributes.credential_on_file_settlement_date).to eq '0201'
      end

      it 'with parsed date time object' do
        attributes.credential_on_file_settlement_date = '1231'

        expect(attributes.instance_variable_get('@credential_on_file_settlement_date')).to be_kind_of DateTime
      end
    end

    describe 'when invalid values' do
      it 'with invalid month' do
        expect { attributes.credential_on_file_settlement_date = '1330' }
          .to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid day' do
        expect { attributes.credential_on_file_settlement_date = '1131' }
          .to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end
end
