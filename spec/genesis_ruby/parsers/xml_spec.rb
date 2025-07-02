# frozen_string_literal: true

RSpec.describe GenesisRuby::Parsers::Xml do
  let(:xml_parser) { described_class.new }
  let(:fixtures_path) { "#{File.dirname(File.dirname(__FILE__))}/fixtures" }

  describe 'with invalid document' do
    it 'raises error with invalid XML document' do
      expect { xml_parser.parse_document('<?xml?><root></root>') }.to raise_error GenesisRuby::ParserError
    end

    it 'raises error with empty XML document' do
      expect { xml_parser.parse_document(nil) }.to raise_error GenesisRuby::ParserError
    end
  end

  describe 'with valid document' do
    describe 'with attributes' do
      let(:response) do
        xml_parser.parse_document(File.open("#{fixtures_path}/sample_xml_attributes_data.xml", 'rb').read)

        xml_parser.structure
      end

      it 'parses root node' do
        expect(response).to include(:root)
      end

      it 'has attributes with root node' do
        expect(response[:root][:attribute1]).to eq('attribute1')
      end

      it 'has element value with root node' do
        expect(response[:root][:element1]).to eq('value1')
      end

      it 'misses root node with skip root node' do
        xml_parser.skip_root_node

        expect(response).to_not include(:root)
      end

      it 'misses attributes with skip root node' do
        xml_parser.skip_root_node

        expect(response).to_not include(:attribute1)
      end

      it 'has element value without root node' do
        xml_parser.skip_root_node

        expect(response[:element1]).to eq('value1')
      end
    end

    describe 'with multiple simple elements' do
      let(:response) do
        xml_parser.skip_root_node
        xml_parser.parse_document(File.open("#{fixtures_path}/sample_xml_data.xml", 'rb').read)

        xml_parser.structure
      end

      it 'has element1 with value1' do
        expect(response[:element1]).to eq('value1')
      end

      it 'has element2 with value 2' do
        expect(response[:element2]).to eq('value2')
      end
    end

    describe 'with gate payment response' do
      let(:response) do
        xml_parser.skip_root_node
        xml_parser.parse_document(
          File.open("#{fixtures_path}/responses/gate_authorize_payment_response.xml", 'rb').read
        )
      end

      it 'has transaction_type' do
        expect(response[:transaction_type]).to eq('authorize3d')
      end

      it 'has status' do
        expect(response[:status]).to eq('approved')
      end

      it 'has authorization_code' do
        expect(response[:authorization_code]).to eq('345678')
      end

      it 'has amount' do
        expect(response[:amount]).to eq('5000')
      end

      it 'has currency' do
        expect(response[:currency]).to eq('USD')
      end

      it 'has card_number' do
        expect(response[:card_number]).to eq('401200...0085')
      end

      it 'has multi-node' do
        expect(response[:threeds]).to be_kind_of Hash
      end

      it 'has threeds authenticaation_flow' do
        expect(response[:threeds][:authentication_flow]).to eq('frictionless')
      end

      it 'has multi-node inside multi-node' do
        expect(response[:threeds][:protocol]).to be_kind_of Hash
      end

      it 'has threeds protocol target_version' do
        expect(response[:threeds][:protocol][:target_version]).to eq('2')
      end

      it 'has threeds protocol concrete version' do
        expect(response[:threeds][:protocol][:concrete_version]).to eq('2')
      end

      it 'has threeds eci' do
        expect(response[:threeds][:eci]).to eq('05')
      end
    end

    describe 'with chargeback date range response' do
      let(:response) do
        xml_parser.parse_document(File.open("#{fixtures_path}/responses/chargeback_date_range.xml"))

        xml_parser.structure
      end

      it 'has page attribute' do
        expect(response[:chargeback_responses][:page]).to eq('1')
      end

      it 'has per_page attribute' do
        expect(response[:chargeback_responses][:per_page]).to eq('100')
      end

      it 'has total_count attribute' do
        expect(response[:chargeback_responses][:total_count]).to eq('12')
      end

      it 'has pages_count attribute' do
        expect(response[:chargeback_responses][:pages_count]).to eq('1')
      end

      it 'has chargeback_response array multi-node' do
        expect(response[:chargeback_responses][:chargeback_response]).to be_kind_of Array
      end

      it 'has correct chargeback_response nodes' do
        expect(response[:chargeback_responses][:chargeback_response].count).to eq(12)
      end

      it 'has empty cnn element' do
        expect(response[:chargeback_responses][:chargeback_response][0][:cnn]).to be_empty
      end

      it 'has chargeback_response type' do
        expect(response[:chargeback_responses][:chargeback_response].sample[:type]).to_not be_empty
      end
    end

    describe 'with wpf creation response' do
      let(:response) do
        xml_parser.skip_root_node
        xml_parser.parse_document(File.open("#{fixtures_path}/responses/gate_wpf_payment.xml"))

        xml_parser.structure
      end

      it 'has status' do
        expect(response[:status]).to eq('new')
      end

      it 'has redirect_url' do
        expect(response[:redirect_url]).to eq('https://staging.wpf.emerchantpay.net/en/v2/payment/1c4ae3aee01fe6fcc346b6c54074d26b')
      end
    end

    describe 'with wpf reconcile response' do
      let(:response) do
        xml_parser.skip_root_node
        xml_parser.parse_document(File.open("#{fixtures_path}/responses/reconcile_wpf.xml"))

        xml_parser.structure
      end

      it 'has status' do
        expect(response[:status]).to eq('refunded')
      end

      it 'has amount' do
        expect(response[:amount]).to eq('1810')
      end

      it 'has payment_transaction multi-node' do
        expect(response[:payment_transaction]).to be_kind_of Array
      end

      it 'has correct payment_transaction count' do
        expect(response[:payment_transaction].count).to eq(2)
      end

      it 'has payment_transaction status' do
        expect(response[:payment_transaction].sample[:status]).to_not be_empty
      end

      it 'has payment_transaction multi-node dynamic_descriptor_params' do
        expect(
          response[:payment_transaction][0][:dynamic_descriptor_params]
        ).to eq({ merchant_name: 'EXAMPLE', merchant_city: 'LONDON' })
      end

      it 'has payment_transaction multi-node threeds' do
        expect(response[:payment_transaction][0][:threeds]).to be_kind_of Hash
      end

      it 'has payment_transaction threeds eci' do
        expect(response[:payment_transaction][0][:threeds][:eci]).to eq('05')
      end

      it 'has payment_transaction threeds protocol' do
        expect(
          response[:payment_transaction][0][:threeds][:protocol]
        ).to eq({ target_version: '2', concrete_version: '1' })
      end

      it 'has payment_transaction billing_address' do # rubocop:disable RSpec/ExampleLength
        expect(
          response[:payment_transaction][0][:billing_address]
        ).to eq({
                  first_name: 'John',
                  last_name:  'Smith',
                  address1:   '1 London Bridge, London SE1 9BG, United Kingdom',
                  address2:   '',
                  zip_code:   '0000',
                  city:       'London',
                  state:      '',
                  country:    'UK'
                })
      end
    end
  end
end
