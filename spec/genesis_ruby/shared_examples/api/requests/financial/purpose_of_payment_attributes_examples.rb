RSpec.shared_examples 'purpose of payment attributes examples' do
  describe 'when purpose of payment attributes' do
    it 'with purpose_of_payment' do
      request.purpose_of_payment = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment.all.sample

      expect(request.build_document).to include "<purpose_of_payment>#{value}</purpose_of_payment>"
    end
  end
end
