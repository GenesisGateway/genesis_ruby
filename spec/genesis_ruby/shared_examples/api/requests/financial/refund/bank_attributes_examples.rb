# frozen_string_literal: true

RSpec.shared_examples 'refund bank attributes examples' do
  describe 'when refund bank attributes' do
    let(:refund_bank_attributes) { %w(bank bank_branch bank_account bank_account_type) }
    let(:refund_bank_document) do
      refund_bank_attributes.each { |name| request.__send__("#{name}=", nil) }

      request
    end

    def refund_bank_elements(name)
      Nokogiri::XML(refund_bank_document.build_document).xpath("/payment_transaction/#{name}").map(&:text)
    end

    it 'without refund bank attributes' do
      xpath = refund_bank_attributes.map { |name| "//#{name}" }.join(' | ')

      expect(Nokogiri::XML(refund_bank_document.build_document).xpath(xpath)).to be_empty
    end

    {
      'bank'              => 'Example Bank',
      'bank_branch'       => 'Example Branch',
      'bank_account'      => '1234567890',
      'bank_account_type' => GenesisRuby::Api::Constants::Transactions::Parameters::Refund::BankAccountTypes::CHECKING
    }.each do |name, value|
      it "with #{name} as a direct child of payment_transaction" do
        refund_bank_document.__send__("#{name}=", value)

        expect(refund_bank_elements(name)).to eq [value]
      end
    end

    %w(invalid c).each do |value|
      it "with bank_account_type #{value} raises ParameterError" do
        refund_bank_document.bank_account_type = value

        expect { refund_bank_document.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end

    GenesisRuby::Api::Constants::Transactions::Parameters::Refund::BankAccountTypes.all.each do |value|
      it "with allowed bank_account_type #{value}" do
        refund_bank_document.bank_account_type = value

        expect(refund_bank_elements('bank_account_type')).to eq [value]
      end
    end
  end
end
