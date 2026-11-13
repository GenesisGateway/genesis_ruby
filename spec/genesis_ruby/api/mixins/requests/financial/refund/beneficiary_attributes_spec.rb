# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/refund/beneficiary_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Refund::BeneficiaryAttributes do
  let(:beneficiary_attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Refund::BeneficiaryAttributesStub.new }

  %w(beneficiary_bank_code beneficiary_name beneficiary_account_number).each do |name|
    describe "when #{name}" do
      it 'with setter' do
        expect { beneficiary_attributes.__send__("#{name}=", "#{name} value") }.to_not raise_error
      end

      it 'with getter' do
        beneficiary_attributes.__send__("#{name}=", "#{name} value")

        expect(beneficiary_attributes.__send__(name)).to eq "#{name} value"
      end

      it 'with nil setter' do
        expect { beneficiary_attributes.__send__("#{name}=", nil) }.to_not raise_error
      end

      it 'with nil value' do
        beneficiary_attributes.__send__("#{name}=", 'value')
        beneficiary_attributes.__send__("#{name}=", nil)

        expect(beneficiary_attributes.__send__(name)).to be_nil
      end

      it 'without assigned value' do
        expect(beneficiary_attributes.__send__(name)).to be_nil
      end
    end
  end

  describe 'when refund_beneficiary_attributes_structure' do
    it 'returns nil values without assigned attributes' do
      expect(beneficiary_attributes.refund_beneficiary_attributes_structure)
        .to eq(beneficiary_bank_code: nil, beneficiary_name: nil, beneficiary_account_number: nil)
    end

    it 'returns the keys in order' do
      expect(beneficiary_attributes.refund_beneficiary_attributes_structure.keys)
        .to eq %i[beneficiary_bank_code beneficiary_name beneficiary_account_number]
    end

    it 'returns flat keys without beneficiary node' do
      expect(beneficiary_attributes.refund_beneficiary_attributes_structure).to_not have_key(:beneficiary)
    end

    it 'returns the assigned values' do
      values = { beneficiary_bank_code: 'Code', beneficiary_name: 'John Doe', beneficiary_account_number: 'Account' }
      values.each { |name, value| beneficiary_attributes.__send__("#{name}=", value) }

      expect(beneficiary_attributes.refund_beneficiary_attributes_structure).to eq values
    end
  end

  describe 'when method names' do
    let(:pix_mixin) { GenesisRuby::Api::Mixins::Requests::Financial::BeneficiaryAttributes }
    let(:mixin_methods) do
      described_class.instance_methods(false) + described_class.protected_instance_methods(false) +
        described_class.private_instance_methods(false)
    end

    def all_methods(mod)
      mod.public_instance_methods + mod.protected_instance_methods + mod.private_instance_methods
    end

    it 'declares the structure helper as protected method' do
      expect(described_class.protected_instance_methods(false)).to eq %i[refund_beneficiary_attributes_structure]
    end

    it 'shares only beneficiary_name accessors with the pix beneficiary attributes' do
      expect(mixin_methods & all_methods(pix_mixin)).to match_array %i[beneficiary_name beneficiary_name=]
    end

    it 'does not define beneficiary_parameters_structure' do
      expect(mixin_methods).to_not include :beneficiary_parameters_structure
    end
  end
end
