# frozen_string_literal: true

RSpec.shared_examples 'birth date attributes examples' do
  describe 'when birth date attributes' do
    it 'without birth_date attributes' do
      expect(request.build_document).to_not include 'birth_date'
    end

    it 'with birth_date attributes' do
      request.birth_date = '1970-01-01'

      expect(request.build_document).to include '<birth_date>01-01-1970</birth_date>'
    end
  end
end
