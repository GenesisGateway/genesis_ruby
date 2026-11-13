# frozen_string_literal: true

RSpec.shared_examples 'refund travel ticket attributes examples' do
  describe 'when refund travel ticket attributes' do
    let(:refund_travel_ticket_attributes) do
      %w(credit_reason_indicator_1 credit_reason_indicator_2 ticket_change_indicator)
    end
    let(:refund_travel_ticket_document) do
      refund_travel_ticket_attributes.each { |name| request.__send__("#{name}=", nil) }

      request
    end

    def refund_travel_ticket_xml
      Nokogiri::XML(refund_travel_ticket_document.build_document)
    end

    def refund_travel_ticket_elements(name)
      refund_travel_ticket_xml.xpath("/payment_transaction/travel/ticket/#{name}").map(&:text)
    end

    it 'without refund travel ticket attributes' do
      expect(refund_travel_ticket_xml.xpath('//travel')).to be_empty
    end

    {
      'credit_reason_indicator_1' => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
                                       CreditReasonIndicators::INDICATOR_A,
      'credit_reason_indicator_2' => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
                                       CreditReasonIndicators::INDICATOR_B,
      'ticket_change_indicator'   => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
                                       TicketChangeIndicators::INDICATOR_C
    }.each do |name, value|
      it "with #{name} only inside payment_transaction travel ticket" do
        refund_travel_ticket_document.__send__("#{name}=", value)

        expect(refund_travel_ticket_xml.xpath("//#{name}").map { |node| [node.path, node.text] })
          .to eq [["/payment_transaction/travel/ticket/#{name}", value]]
      end

      ['invalid', value.downcase].each do |invalid_value|
        it "with #{name} #{invalid_value} raises ParameterError" do
          refund_travel_ticket_document.__send__("#{name}=", invalid_value)

          expect { refund_travel_ticket_document.build_document }.to raise_error GenesisRuby::ParameterError
        end
      end
    end

    {
      'credit_reason_indicator_1' => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
                                       CreditReasonIndicators.all,
      'credit_reason_indicator_2' => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
                                       CreditReasonIndicators.all,
      'ticket_change_indicator'   => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::
                                       TicketChangeIndicators.all
    }.each do |name, values|
      values.each do |value|
        it "with allowed #{name} #{value}" do
          refund_travel_ticket_document.__send__("#{name}=", value)

          expect(refund_travel_ticket_elements(name)).to eq [value]
        end
      end
    end
  end
end
