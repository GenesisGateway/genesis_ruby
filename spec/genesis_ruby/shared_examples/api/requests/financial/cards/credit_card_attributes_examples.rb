RSpec.shared_examples 'credit card attributes examples' do
  describe 'when credit card attributes' do
    it 'with card_holder' do
      request.card_holder = name = Faker::Name.name_with_middle

      expect(request.build_document).to include "<card_holder>#{name}</card_holder>"
    end

    it 'with card_number' do
      request.card_number = card_number = Faker::Finance.credit_card

      expect(request.build_document).to include "<card_number>#{card_number}</card_number>"
    end

    it 'with expiration_month' do
      request.expiration_month = expiration_month = Faker::Date.in_date_period.strftime '%m'

      expect(request.build_document).to include "<expiration_month>#{expiration_month}</expiration_month>"
    end

    it 'with expiration_year' do
      request.expiration_year = expiration_year = Faker::Date.in_date_period.strftime '%Y'

      expect(request.build_document).to include "<expiration_year>#{expiration_year}</expiration_year>"
    end

    it 'with cvv' do
      request.cvv = cvv = Faker::Number.positive from: 100, to: 999

      expect(request.build_document).to include "<cvv>#{cvv}</cvv>"
    end

    it 'without expiration_year' do
      request.expiration_year = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'without expiration_month' do
      request.expiration_month = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'without card_holder' do
      request.card_holder = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
