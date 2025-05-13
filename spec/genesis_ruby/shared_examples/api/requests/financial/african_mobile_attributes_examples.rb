RSpec.shared_examples 'african mobile attributes examples' do
  describe 'when african mobile attributes' do
    it 'with target' do
      request.target = value = Faker::Lorem.characters(number: 20)

      expect(request.build_document).to include "<target>#{value}</target>"
    end

    it 'with operator' do
      request.operator = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::AfricanMobileOperators::SAFARICOM

      expect(request.build_document).to include "<operator>#{value}</operator>"
    end
  end
end
