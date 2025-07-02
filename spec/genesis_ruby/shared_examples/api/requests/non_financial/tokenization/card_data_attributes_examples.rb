# frozen_string_literal: true

RSpec.shared_examples 'card data attributes examples' do
  describe 'when card data attributes' do
    it 'with card_number' do
      request.card_number = '1234567890123456789'

      expect(request.build_document).to include '<card_number>1234567890123456789</card_number>'
    end

    describe 'when card_holder' do
      it 'with value' do
        request.card_holder = value = Faker::Address.name

        expect(request.build_document).to include "<card_holder>#{value}</card_holder>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include 'card_holder'
      end
    end

    describe 'when expiration_month' do
      it 'with value' do
        request.expiration_month = value = Faker::Date.in_date_period.strftime('%m')

        expect(request.build_document).to include "<expiration_month>#{value}</expiration_month>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include 'expiration_month'
      end
    end

    describe 'when expiration_year' do
      it 'with value' do
        request.expiration_year = value = Faker::Date.in_date_period.strftime('%Y')

        expect(request.build_document).to include "<expiration_year>#{value}</expiration_year>"
      end

      it 'without assignment' do
        expect(request.build_document).to_not include 'expiration_year'
      end
    end
  end
end
