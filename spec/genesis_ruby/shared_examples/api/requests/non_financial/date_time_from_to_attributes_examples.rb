# frozen_string_literal: true

# Request-level DateTimeFromToAttributes examples. The including spec provides a +request+ let built
# with a valid filter and response_fields = ['id']. Covers query rendering and the Date_Range_Pair rules.
RSpec.shared_examples 'date time from to attributes examples' do
  describe 'when date time from to attributes rendered in the generated query' do
    it 'with start_date_from and start_date_to' do
      request.start_date_from = '2024-01-01'
      request.start_date_to   = '2024-01-07'

      expect(request.build_document).to include('startDateFrom: "2024-01-01"').and include('startDateTo: "2024-01-07"')
    end

    it 'with end_date_from and end_date_to' do
      request.end_date_from = '2024-01-01'
      request.end_date_to   = '2024-01-07'

      expect(request.build_document).to include('endDateFrom: "2024-01-01"').and include('endDateTo: "2024-01-07"')
    end

    it 'with datetime value rendered unchanged' do
      request.start_date_from = '2024-01-01 10:00:00'
      request.start_date_to   = '2024-01-02 10:00:00'

      expect(request.build_document).to include('startDateFrom: "2024-01-01 10:00:00"')
        .and include('startDateTo: "2024-01-02 10:00:00"')
    end
  end

  %w(start end).each do |prefix|
    describe "when #{prefix} date range pair" do
      let(:from_setter) { :"#{prefix}_date_from=" }
      let(:to_setter) { :"#{prefix}_date_to=" }

      it 'with only the from boundary raises ParameterError' do
        request.public_send from_setter, '1970-01-01'

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with only the to boundary raises ParameterError' do
        request.public_send to_setter, '1970-01-07'

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with a reversed pair raises ParameterError' do
        request.public_send from_setter, '1970-01-02'
        request.public_send to_setter, '1970-01-01'

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'when span greater than seven days raises ParameterError' do
        request.public_send from_setter, '1970-01-01'
        request.public_send to_setter, '1970-01-09'

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with equal boundaries is accepted' do
        request.public_send from_setter, '1970-01-01'
        request.public_send to_setter, '1970-01-01'

        expect { request.build_document }.to_not raise_error
      end

      it 'with an exactly seven-day span is accepted' do
        request.public_send from_setter, '1970-01-01'
        request.public_send to_setter, '1970-01-08'

        expect { request.build_document }.to_not raise_error
      end
    end

    describe "when a #{prefix}_date_from assignment fails" do
      let(:getter) { :"#{prefix}_date_from" }
      let(:setter) { :"#{prefix}_date_from=" }

      # A failed assignment must not change the formatting of a previously stored valid date:
      # the time-presence flag is updated only after the date is parsed successfully.
      it 'preserves the previously stored datetime formatting' do # rubocop:disable RSpec/MultipleExpectations
        request.public_send setter, '1970-01-01 10:00:00'

        expect { request.public_send setter, 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
        expect(request.public_send(getter)).to eq '1970-01-01 10:00:00'
      end
    end
  end
end
