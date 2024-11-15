RSpec.shared_examples 'recurring type mobile tokenized examples' do
  describe 'when recurring type' do
    it 'with initial recurring type' do
      request.recurring_type = type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL

      expect(request.recurring_type).to eq type
    end

    it 'has proper structure without recurring type' do
      expect(request.build_document).to_not include 'recurring_type'
    end

    it 'has proper structure with recurring type' do
      request.recurring_type = type  = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL

      expect(request.build_document).to include "<recurring_type>#{type}</recurring_type>"
    end

    it 'can unset recurring type' do
      request.recurring_type = nil

      expect(request.build_document).to_not include 'recurring_type'
    end

    it 'without managed recurring type' do
      request.recurring_type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::MANAGED

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'without subsequent recurring type' do
      request.recurring_type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::SUBSEQUENT

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
