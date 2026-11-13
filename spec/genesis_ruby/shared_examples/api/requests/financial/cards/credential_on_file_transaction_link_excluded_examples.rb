# frozen_string_literal: true

RSpec.shared_examples 'credential on file transaction link excluded examples' do |expected_cof_elements|
  describe 'when credential on file transaction link is excluded' do
    let(:cof_elements) do
      %i[credential_on_file credential_on_file_transaction_identifier credential_on_file_settlement_date]
    end
    let(:cof_values) do
      {
        credential_on_file:                        GenesisRuby::Api::Constants::Transactions::Parameters::
                                                     CredentialOnFiles::MERCHANT_UNSCHEDULED,
        credential_on_file_transaction_identifier: 'ABCDEF0123456789XYZ',
        credential_on_file_settlement_date:        '0107'
      }
    end

    it 'does not respond to credential_on_file_transaction_link_id reader' do
      expect(request.respond_to?(:credential_on_file_transaction_link_id)).to be false
    end

    it 'does not respond to credential_on_file_transaction_link_id setter' do
      expect(request.respond_to?(:credential_on_file_transaction_link_id=)).to be false
    end

    it 'does not define credential_on_file_transaction_link_id in the CreditCard base class' do
      credit_card_class = GenesisRuby::Api::Requests::Base::Financials::CreditCard

      expect(credit_card_class.method_defined?(:credential_on_file_transaction_link_id)).to be false
    end

    it 'generates document without credential_on_file_transaction_link_id element' do
      document = Nokogiri::XML request.build_document

      expect(document.xpath('//credential_on_file_transaction_link_id')).to be_empty
    end

    describe 'with valid credential on file values' do
      let(:document) do
        expected_cof_elements.each do |name|
          request.public_send("#{name}=", cof_values[name])
        end

        Nokogiri::XML request.build_document
      end

      it 'generates each expected element exactly once with the set value' do
        expected_cof_elements.each do |name|
          texts = document.xpath("/payment_transaction/#{name}").map(&:text)

          expect(texts).to eq([cof_values[name]]), "expected exactly one <#{name}> with the set value, got #{texts}"
        end
      end

      it 'does not generate credential on file elements outside the expected list' do
        (cof_elements - expected_cof_elements).each do |name|
          expect(document.xpath("//#{name}")).to be_empty, "expected no <#{name}> element"
        end
      end

      it 'does not generate credential_on_file_transaction_link_id element' do
        expect(document.xpath('//credential_on_file_transaction_link_id')).to be_empty
      end
    end

    describe 'with nil credential on file values' do
      # The identifier writer rejects nil (min length 15), so it keeps its initial nil value
      before do
        request.credential_on_file = nil
        if expected_cof_elements.include? :credential_on_file_settlement_date
          request.credential_on_file_settlement_date = nil
        end
      end

      it 'keeps credential_on_file_transaction_identifier nil' do
        expect(request.credential_on_file_transaction_identifier).to be_nil
      end

      it 'builds the document without ParameterError' do
        expect { request.build_document }.to_not raise_error
      end

      it 'omits the credential on file elements' do
        document = Nokogiri::XML request.build_document

        cof_elements.each do |name|
          expect(document.xpath("//#{name}")).to be_empty, "expected no <#{name}> element"
        end
      end
    end
  end
end
