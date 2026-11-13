# frozen_string_literal: true

require 'nokogiri'

RSpec.shared_examples 'order attributes examples' do
  describe 'when order attributes' do
    let(:order_xml) { Nokogiri::XML(request.build_document) }
    let(:order_id) { "ORD-#{Faker::Number.number(digits: 8)}" }

    it 'has nil order_id by default' do
      expect(described_class.new(config).order_id).to be_nil
    end

    it 'omits order_id when unset' do
      expect(order_xml.root.xpath('order_id')).to be_empty
    end

    it 'omits order_id when empty' do
      request.order_id = ''

      expect(order_xml.root.xpath('order_id')).to be_empty
    end

    it 'contains single order_id' do
      request.order_id = order_id

      expect(order_xml.root.xpath('order_id').size).to eq 1
    end

    it 'contains order_id value' do
      request.order_id = order_id

      expect(order_xml.root.at_xpath('order_id').text).to eq order_id
    end

    it 'contains order_id with xml special characters' do
      request.order_id = 'ORD & <1>'

      expect(order_xml.root.at_xpath('order_id').text).to eq 'ORD & <1>'
    end

    it 'raises error with order_id over max length' do
      expect { request.order_id = 'a' * 256 }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
