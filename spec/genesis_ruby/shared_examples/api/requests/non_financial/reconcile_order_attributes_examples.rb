# frozen_string_literal: true

RSpec.shared_examples 'reconcile order attributes examples' do
  describe 'when reconcile order attributes' do
    it 'with order_id' do
      expect(request.build_document).to include "<order_id>#{request.order_id}</order_id>"
    end

    it 'without order_id' do
      request.order_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with 255 characters order_id' do
      request.order_id = 'a' * 255
      expect(request.build_document).to include "<order_id>#{"a" * 255}</order_id>"
    end

    it 'with 256 characters order_id' do
      expect { request.order_id = 'a' * 256 }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'without page node' do
      expect(request.build_document).to_not include '<page>'
    end

    it 'without per_page node' do
      expect(request.build_document).to_not include '<per_page>'
    end

    it 'without page accessor' do
      expect(request).to_not respond_to(:page)
    end

    it 'without per_page accessor' do
      expect(request).to_not respond_to(:per_page)
    end
  end
end
