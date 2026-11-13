# frozen_string_literal: true

# Shared examples for the Force_3DS_Request classes (Authorize3d, Sale3d, ApplePay, GooglePay)
# Relies on a valid and buildable `let(:request)` defined in the including spec
RSpec.shared_examples 'force threeds attributes examples' do
  describe 'when force threeds attributes' do
    let(:force_threeds_document) { Nokogiri::XML(request.build_document) }

    it 'responds to the force_threeds reader' do
      expect(request.respond_to?(:force_threeds)).to be true
    end

    it 'responds to the force_threeds setter' do
      expect(request.respond_to?(:force_threeds=)).to be true
    end

    it 'has a nil initial value' do
      expect(request.force_threeds).to be_nil
    end

    describe 'with accepted values' do
      it 'accepts true' do
        request.force_threeds = true

        expect(request.force_threeds).to be true
      end

      it 'accepts false' do
        request.force_threeds = false

        expect(request.force_threeds).to be false
      end

      it 'accepts nil' do
        request.force_threeds = true
        request.force_threeds = nil

        expect(request.force_threeds).to be_nil
      end

      it 'accepts empty string as nil' do
        request.force_threeds = true
        request.force_threeds = ''

        expect(request.force_threeds).to be_nil
      end
    end

    describe 'with rejected values' do
      ['true', 'false', 1, 0, 'true'.to_sym].each do |value|
        it "raises InvalidArgumentError for #{value.inspect}" do
          expect { request.force_threeds = value }.to raise_error GenesisRuby::InvalidArgumentError
        end
      end
    end

    describe 'with XML document' do
      it 'serializes true as a direct child of payment_transaction' do
        request.force_threeds = true

        nodes = force_threeds_document.xpath('/payment_transaction/force_threeds')

        expect(nodes.map(&:text)).to eq ['true']
      end

      it 'serializes false as a direct child of payment_transaction' do
        request.force_threeds = false

        nodes = force_threeds_document.xpath('/payment_transaction/force_threeds')

        expect(nodes.map(&:text)).to eq ['false']
      end

      it 'omits the element when nil' do
        request.force_threeds = nil

        expect(force_threeds_document.xpath('//force_threeds')).to be_empty
      end

      it 'omits the element when never assigned' do
        expect(force_threeds_document.xpath('//force_threeds')).to be_empty
      end

      it 'omits the element when empty string is assigned after true' do
        request.force_threeds = true
        request.force_threeds = ''

        expect(force_threeds_document.xpath('//force_threeds')).to be_empty
      end
    end

    describe 'with validation' do
      it 'does not raise ParameterError when nil' do
        request.force_threeds = nil

        expect { request.build_document }.to_not raise_error
      end

      it 'builds successfully when true without 3DSv2 parameters' do
        request.force_threeds = true

        expect { request.build_document }.to_not raise_error
      end
    end

    describe 'without side effects from build_document' do
      [true, false, nil].each do |value|
        it "keeps #{value.inspect} after a successful build" do
          request.force_threeds = value
          request.build_document

          expect(request.force_threeds).to eq value
        end

        it "keeps #{value.inspect} after a build with ParameterError", :aggregate_failures do
          request.force_threeds = value
          request.amount        = nil

          expect { request.build_document }.to raise_error GenesisRuby::ParameterError
          expect(request.force_threeds).to eq value
        end
      end
    end
  end
end
