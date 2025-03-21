require 'spec/genesis_ruby/stubs/api/requests/financial/cards/installment_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::InstallmentAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::InstallmentAttributesStub.new }

  describe 'when installment_plan_id' do
    let(:identifier) { Faker::Internet.uuid }

    it 'with getter' do
      attributes.installment_plan_id = identifier

      expect(attributes.installment_plan_id).to eq identifier
    end

    it 'with setter' do
      expect { attributes.installment_plan_id = identifier }.to_not raise_error
    end
  end

  describe 'when installment_plan_reference' do
    let(:identifier) { Faker::Internet.uuid }

    it 'with getter' do
      attributes.installment_plan_reference = identifier

      expect(attributes.installment_plan_reference).to eq identifier
    end

    it 'with setter' do
      expect { attributes.installment_plan_reference = identifier }.to_not raise_error
    end
  end
end
