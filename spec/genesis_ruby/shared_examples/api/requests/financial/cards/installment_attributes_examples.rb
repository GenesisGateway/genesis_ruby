# frozen_string_literal: true

RSpec.shared_examples 'installment attributes examples' do
  describe 'when Installment Attributes' do
    it 'when installment_plan_id without value' do
      expect(request.build_document).to_not include 'installment_plan_id'
    end

    it 'when installment_plan_reference wihout value' do
      expect(request.build_document).to_not include 'installment_plan_reference'
    end

    it 'when installment_plan_id with value' do
      request.installment_plan_id = identifier = Faker::Internet.uuid

      expect(request.build_document).to include "<installment_plan_id>#{identifier}</installment_plan_id>"
    end

    it 'when installment_plan_reference with value' do
      request.installment_plan_reference = identifier = Faker::Internet.uuid

      expect(request.build_document).to include "<installment_plan_reference>#{identifier}</installment_plan_reference>"
    end
  end
end
