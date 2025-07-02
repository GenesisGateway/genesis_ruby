# frozen_string_literal: true

RSpec.shared_examples 'moto attributes examples' do
  describe 'when moto attributes' do
    it 'without moto attributes' do
      expect(request.build_document).to_not include 'moto'
    end

    it 'with moto attributes' do
      request.moto = true

      expectation = '<moto>true</moto>'
      expectation = '"moto": true' if request.instance_variable_get('@builder_interface') == 'json'

      expect(request.build_document).to include expectation
    end
  end
end
