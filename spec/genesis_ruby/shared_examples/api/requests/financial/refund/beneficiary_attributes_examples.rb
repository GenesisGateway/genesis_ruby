# frozen_string_literal: true

RSpec.shared_examples 'refund beneficiary attributes examples' do
  describe 'when refund beneficiary attributes' do
    let(:refund_beneficiary_attributes) { %w(beneficiary_bank_code beneficiary_name beneficiary_account_number) }
    let(:refund_beneficiary_document) do
      refund_beneficiary_attributes.each { |name| request.__send__("#{name}=", nil) }

      request
    end

    def refund_beneficiary_elements(name)
      Nokogiri::XML(refund_beneficiary_document.build_document).xpath("/payment_transaction/#{name}").map(&:text)
    end

    it 'without refund beneficiary attributes' do
      xpath = refund_beneficiary_attributes.map { |name| "//#{name}" }.join(' | ')

      expect(Nokogiri::XML(refund_beneficiary_document.build_document).xpath(xpath)).to be_empty
    end

    {
      'beneficiary_bank_code'      => '0001',
      'beneficiary_name'           => 'John Doe',
      'beneficiary_account_number' => '1234567890'
    }.each do |name, value|
      it "with #{name} as a direct child of payment_transaction" do
        refund_beneficiary_document.__send__("#{name}=", value)

        expect(refund_beneficiary_elements(name)).to eq [value]
      end
    end

    ['invalid', 'c', 'Any value 123 !@#'].each do |value|
      it "with any String value #{value} builds the document" do
        refund_beneficiary_attributes.each { |name| refund_beneficiary_document.__send__("#{name}=", value) }

        expect { refund_beneficiary_document.build_document }.to_not raise_error
      end
    end
  end
end
