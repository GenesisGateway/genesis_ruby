# frozen_string_literal: true

require 'bigdecimal'
require 'spec/genesis_ruby/stubs/api/requests/financial/commercial_card_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::CommercialCardAttributes do
  subject(:stub) do
    GenesisSpec::Stubs::Api::Requests::Financial::CommercialCardAttributesStub.new(GenesisRuby::Configuration.new)
  end

  let(:name) { Faker::Alphanumeric.alphanumeric(number: 35) }
  let(:reference) { Faker::Alphanumeric.alphanumeric(number: 15) }
  let(:customer_code) { Faker::Alphanumeric.alphanumeric(number: 17) }

  describe 'when commercial_card_name' do
    it 'with setter and getter at max length' do
      stub.commercial_card_name = name

      expect(stub.commercial_card_name).to eq name
    end

    it 'with nil clearing' do
      stub.commercial_card_name = name
      stub.commercial_card_name = nil

      expect(stub.commercial_card_name).to be_nil
    end

    it 'with empty clearing' do
      stub.commercial_card_name = name
      stub.commercial_card_name = ''

      expect(stub.commercial_card_name).to be_nil
    end

    it 'with value longer than max' do
      expect { stub.commercial_card_name = Faker::Alphanumeric.alphanumeric(number: 36) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when commercial_card_reference' do
    it 'with setter and getter at max length' do
      stub.commercial_card_reference = reference

      expect(stub.commercial_card_reference).to eq reference
    end

    it 'with value longer than max' do
      expect { stub.commercial_card_reference = Faker::Alphanumeric.alphanumeric(number: 16) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when commercial_card_customer_code' do
    it 'with setter and getter at max length' do
      stub.commercial_card_customer_code = customer_code

      expect(stub.commercial_card_customer_code).to eq customer_code
    end

    it 'with value longer than max' do
      expect { stub.commercial_card_customer_code = Faker::Alphanumeric.alphanumeric(number: 18) }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when commercial_card_quantity' do
    it 'with setter and getter' do
      stub.commercial_card_quantity = 1

      expect(stub.commercial_card_quantity).to eq 1
    end

    it 'with nil clearing' do
      stub.commercial_card_quantity = 1
      stub.commercial_card_quantity = nil

      expect(stub.commercial_card_quantity).to be_nil
    end

    it 'with empty clearing' do
      stub.commercial_card_quantity = 1
      stub.commercial_card_quantity = ''

      expect(stub.commercial_card_quantity).to be_nil
    end

    it 'with upper bound value' do
      stub.commercial_card_quantity = 9_999_999_999

      expect(stub.commercial_card_quantity).to eq 9_999_999_999
    end

    it 'with digit String stored as Integer' do
      stub.commercial_card_quantity = '0042'

      expect(stub.commercial_card_quantity).to eq 42
    end

    it 'with value below range' do
      expect { stub.commercial_card_quantity = 0 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with value above range' do
      expect { stub.commercial_card_quantity = 10_000_000_000 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with non-numeric String' do
      expect { stub.commercial_card_quantity = 'abc' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when commercial_card_tax_rate' do
    it 'with Float stored as textual form' do
      stub.commercial_card_tax_rate = 12.34

      expect(stub.commercial_card_tax_rate).to eq '12.34'
    end

    it 'with nil clearing' do
      stub.commercial_card_tax_rate = 12.34
      stub.commercial_card_tax_rate = nil

      expect(stub.commercial_card_tax_rate).to be_nil
    end

    it 'with empty clearing' do
      stub.commercial_card_tax_rate = 12.34
      stub.commercial_card_tax_rate = ''

      expect(stub.commercial_card_tax_rate).to be_nil
    end

    it 'with lower bound value' do
      stub.commercial_card_tax_rate = 0.01

      expect(stub.commercial_card_tax_rate).to eq '0.01'
    end

    it 'with upper bound value' do
      stub.commercial_card_tax_rate = 99.99

      expect(stub.commercial_card_tax_rate).to eq '99.99'
    end

    it 'with BigDecimal stored as textual form' do
      stub.commercial_card_tax_rate = BigDecimal('12.34')

      expect(stub.commercial_card_tax_rate).to eq '12.34'
    end

    it 'with zero value' do
      expect { stub.commercial_card_tax_rate = 0 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with value above range' do
      expect { stub.commercial_card_tax_rate = 100 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with too many decimal places' do
      expect { stub.commercial_card_tax_rate = '12.345' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with comma decimal separator' do
      expect { stub.commercial_card_tax_rate = '12,34' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when commercial_card_unit_price' do
    it 'with BigDecimal stored as textual form' do
      stub.commercial_card_unit_price = BigDecimal('12.34')

      expect(stub.commercial_card_unit_price).to eq '12.34'
    end

    it 'with nil clearing' do
      stub.commercial_card_unit_price = '12.34'
      stub.commercial_card_unit_price = nil

      expect(stub.commercial_card_unit_price).to be_nil
    end

    it 'with empty clearing' do
      stub.commercial_card_unit_price = '12.34'
      stub.commercial_card_unit_price = ''

      expect(stub.commercial_card_unit_price).to be_nil
    end
  end

  describe 'when commercial_card_total_tax_amount' do
    it 'with setter and getter' do
      stub.commercial_card_total_tax_amount = '1.50'

      expect(stub.commercial_card_total_tax_amount).to eq '1.50'
    end
  end

  describe 'when commercial_card_total_discount_amount' do
    it 'with setter and getter' do
      stub.commercial_card_total_discount_amount = '0.25'

      expect(stub.commercial_card_total_discount_amount).to eq '0.25'
    end
  end

  describe 'when commercial_card_attributes_structure' do
    it 'with tax rate converted to minor percent units' do
      stub.currency                 = 'JPY'
      stub.commercial_card_tax_rate = 2.2

      expect(stub.commercial_card_attributes_structure[:item][:tax_rate]).to eq 220
    end
  end

  describe 'when validate_commercial_card_attributes' do
    def set_valid_base_data
      stub.commercial_card_name                  = name
      stub.commercial_card_quantity              = 1
      stub.commercial_card_unit_price            = '12.34'
      stub.commercial_card_tax_rate              = 12.34
      stub.commercial_card_total_tax_amount      = '1.50'
      stub.commercial_card_total_discount_amount = 0
    end

    it 'with missing tax rate' do
      set_valid_base_data
      stub.commercial_card_tax_rate = nil

      expect { stub.validate_commercial_card_attributes }
        .to raise_error GenesisRuby::ParameterError, /commercial_card_tax_rate/
    end

    it 'with missing name and reference' do
      set_valid_base_data
      stub.commercial_card_name      = nil
      stub.commercial_card_reference = nil

      expect { stub.validate_commercial_card_attributes }
        .to raise_error GenesisRuby::ParameterError, /commercial_card_name.*commercial_card_reference/
    end
  end
end
