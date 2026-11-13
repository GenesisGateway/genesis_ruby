# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/refund/bank_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Refund::BankAttributes do
  let(:bank_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Refund::BankAttributesStub.new }
  let(:account_types) { GenesisRuby::Api::Constants::Transactions::Parameters::Refund::BankAccountTypes }

  %w(bank bank_branch bank_account).each do |name|
    describe "when #{name}" do
      it 'with setter' do
        expect { bank_attributes.__send__("#{name}=", "#{name} value") }.to_not raise_error
      end

      it 'with getter' do
        bank_attributes.__send__("#{name}=", "#{name} value")

        expect(bank_attributes.__send__(name)).to eq "#{name} value"
      end

      it 'with nil value' do
        bank_attributes.__send__("#{name}=", 'value')
        bank_attributes.__send__("#{name}=", nil)

        expect(bank_attributes.__send__(name)).to be_nil
      end

      it 'without assigned value' do
        expect(bank_attributes.__send__(name)).to be_nil
      end
    end
  end

  describe 'when bank_account_type' do
    it 'with setter' do
      account_types.all.each do |value|
        expect { bank_attributes.bank_account_type = value }.to_not raise_error
      end
    end

    it 'with getter' do
      account_types.all.each do |value|
        bank_attributes.bank_account_type = value

        expect(bank_attributes.bank_account_type).to eq value
      end
    end

    it 'with invalid value setter' do
      %w(invalid c).each do |value|
        expect { bank_attributes.bank_account_type = value }.to_not raise_error
      end
    end

    it 'with invalid value getter' do
      %w(invalid c).each do |value|
        bank_attributes.bank_account_type = value

        expect(bank_attributes.bank_account_type).to eq value
      end
    end

    it 'with nil value' do
      bank_attributes.bank_account_type = account_types::CHECKING
      bank_attributes.bank_account_type = nil

      expect(bank_attributes.bank_account_type).to be_nil
    end

    it 'without assigned value' do
      expect(bank_attributes.bank_account_type).to be_nil
    end
  end

  describe 'when refund_bank_attributes_structure' do
    it 'returns nil values without assigned attributes' do
      expect(bank_attributes.refund_bank_attributes_structure)
        .to eq(bank: nil, bank_branch: nil, bank_account: nil, bank_account_type: nil)
    end

    it 'returns the keys in order' do
      expect(bank_attributes.refund_bank_attributes_structure.keys)
        .to eq %i[bank bank_branch bank_account bank_account_type]
    end

    it 'returns the assigned values' do
      values = { bank: 'Bank', bank_branch: 'Branch', bank_account: 'Account' }
      values[:bank_account_type] = account_types::SAVINGS
      values.each { |name, value| bank_attributes.__send__("#{name}=", value) }

      expect(bank_attributes.refund_bank_attributes_structure).to eq values
    end
  end

  describe 'when refund_bank_attributes_field_validations' do
    it 'returns the bank account types' do
      expect(bank_attributes.refund_bank_attributes_field_validations).to eq(bank_account_type: account_types.all)
    end

    it 'returns all allowed bank account type values' do
      expect(bank_attributes.refund_bank_attributes_field_validations[:bank_account_type])
        .to match_array %w(C I S)
    end
  end

  describe 'when method names' do
    let(:helper_names) { %i[refund_bank_attributes_structure refund_bank_attributes_field_validations] }
    let(:mixin_methods) { described_class.instance_methods(false) + described_class.private_instance_methods(false) }

    def all_methods(mod)
      mod.public_instance_methods + mod.protected_instance_methods + mod.private_instance_methods
    end

    it 'declares the helpers as protected methods' do
      expect(described_class.protected_instance_methods(false)).to match_array helper_names
    end

    it 'does not clash with the financial bank attributes' do
      expect(mixin_methods & all_methods(GenesisRuby::Api::Mixins::Requests::Financial::BankAttributes)).to be_empty
    end

    it 'does not clash with the base reference request' do
      expect(mixin_methods & all_methods(GenesisRuby::Api::Requests::Base::Reference)).to be_empty
    end

    it 'does not clash with the refund request own methods' do
      refund = GenesisRuby::Api::Requests::Financial::Refund
      own_methods = all_methods(refund).reject { |name| refund.instance_method(name).owner == described_class }

      expect(helper_names & own_methods).to be_empty
    end
  end
end
