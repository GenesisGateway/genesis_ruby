# frozen_string_literal: true

RSpec.shared_examples 'commercial card attributes examples' do
  describe 'when commercial card attributes' do
    let(:commercial_card_name) { Faker::Commerce.product_name.slice(0, 30) }
    let(:commercial_card_reference) { Faker::Alphanumeric.alphanumeric(number: 10) }
    let(:commercial_card_customer_code) { Faker::Alphanumeric.alphanumeric(number: 12) }

    before do
      request.amount   = '100.00'
      request.currency = 'EUR'
    end

    it 'does not render the items node without commercial card attributes' do
      expect(request.build_document).to_not include '<items>'
    end

    # rubocop:disable RSpec/ExampleLength
    it 'renders every commercial card item child with its value' do
      request.commercial_card_name                  = commercial_card_name
      request.commercial_card_reference             = commercial_card_reference
      request.commercial_card_customer_code         = commercial_card_customer_code
      request.commercial_card_quantity              = 10
      request.commercial_card_unit_price            = '150.00'
      request.commercial_card_tax_rate              = 12.34
      request.commercial_card_total_tax_amount      = '18.51'
      request.commercial_card_total_discount_amount = '0.00'

      parser = GenesisRuby::Parser.new GenesisRuby::Parser::XML
      parser.parse_document request.build_document

      expect(parser.structure[:payment_transaction][:items]).to eq(
        item: {
          item_type:             'commercial_card',
          name:                  commercial_card_name,
          reference:             commercial_card_reference,
          quantity:              '10',
          unit_price:            '15000',
          tax_rate:              '1234',
          total_tax_amount:      '1851',
          total_discount_amount: '0',
          merchant_data:         { customer_code: commercial_card_customer_code }
        }
      )
    end
    # rubocop:enable RSpec/ExampleLength

    it 'raises when only the customer code is set' do
      request.commercial_card_customer_code = commercial_card_customer_code

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError, /commercial_card_quantity/
    end
  end
end
