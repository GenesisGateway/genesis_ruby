# frozen_string_literal: true

RSpec.shared_examples 'pix attributes examples' do
  describe 'when pix attributes' do
    describe 'when incorporation_date' do
      it 'with empty value' do
        request.incorporation_date = nil

        expect(request.build_document).to_not include 'incorporation_date'
      end

      it 'with proper value' do
        request.incorporation_date = '01-01-1970'

        date = '1970-01-01'
        date = '01-01-1970' if request.is_a? GenesisRuby::Api::Requests::Financial::CashPayments::Pix

        expect(request.build_document).to include "<incorporation_date>#{date}</incorporation_date>"
      end

      it 'with invalid value' do
        expect { request.incorporation_date = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
      end
    end

    describe 'when mothers_name' do
      it 'with empty value' do
        request.mothers_name = nil

        expect(request.build_document).to_not include 'mothers_name'
      end

      it 'with proper value' do
        request.mothers_name = Faker::Name.female_first_name

        expect(request.build_document).to include "<mothers_name>#{request.mothers_name}</mothers_name>"
      end
    end

    describe 'when company_type' do
      it 'with empty value' do
        request.company_type = nil

        expect(request.build_document).to_not include 'company_type'
      end

      it 'with proper value' do
        request.company_type = GenesisRuby::Api::Constants::Transactions::Parameters::CashPayments::
            CompanyTypes.all.sample

        expect(request.build_document).to include "<company_type>#{request.company_type}</company_type>"
      end
    end

    describe 'when company_activity' do
      it 'with empty value' do
        request.company_activity = nil

        expect(request.build_document).to_not include 'company_activity'
      end

      it 'with proper value' do
        request.company_activity = Faker::Lorem.word

        expect(request.build_document).to include "<company_activity>#{request.company_activity}</company_activity>"
      end
    end
  end
end
