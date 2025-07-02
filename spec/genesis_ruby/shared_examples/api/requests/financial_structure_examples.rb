# frozen_string_literal: true

RSpec.shared_examples 'financial structure examples' do
  describe 'when financial Hash structure' do
    it 'with root payment_transaction key' do
      expect(request.__send__(:populate_structure)).to include :payment_transaction
    end

    it 'with transaction_type key' do
      expect(request.__send__(:populate_structure)[:payment_transaction]).to include :transaction_type
    end

    it 'with transaction_id key' do
      expect(request.__send__(:populate_structure)[:payment_transaction]).to include :transaction_id
    end

    it 'with usage key' do
      expect(request.__send__(:populate_structure)[:payment_transaction]).to include :usage
    end

    it 'with remote_ip key' do
      expect(request.__send__(:populate_structure)[:payment_transaction]).to include :remote_ip
    end
  end
end
