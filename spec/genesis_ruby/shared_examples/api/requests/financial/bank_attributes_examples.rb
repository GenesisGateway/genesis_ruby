# frozen_string_literal: true

RSpec.shared_examples 'bank attributes examples' do
  describe 'when bank attributes' do
    it 'when build_document with bic element' do
      request.bic = bic = Faker::Bank.swift_bic
      expect(request.build_document).to include("<bic>#{bic}</bic>")
    end

    it 'when build_document with iban element' do
      request.iban = iban = Faker::Bank.iban
      expect(request.build_document).to include("<iban>#{iban}</iban>")
    end

  end
end
