# frozen_string_literal: true

# Shared examples only for Force_3DS_V2_Request classes (Authorize3d, Sale3d, GooglePay)
RSpec.shared_examples 'force threeds with threeds v2 examples' do
  describe 'when force_threeds with threeds v2 attributes' do
    # The including specs do not set any threeds_v2_* attributes in let(:request), so they are nil by default
    before do
      request.force_threeds = true
    end

    describe 'without threeds v2 attributes' do
      it 'builds without ParameterError' do
        expect { request.build_document }.to_not raise_error
      end

      it 'contains force_threeds element' do
        document = Nokogiri::XML request.build_document

        expect(document.xpath('/payment_transaction/force_threeds').map(&:text)).to eq ['true']
      end

      it 'does not contain threeds_v2_params element' do
        document = Nokogiri::XML request.build_document

        expect(document.xpath('//threeds_v2_params')).to be_empty
      end
    end

    describe 'with threeds_v2_control_device_type' do
      let(:device_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::DeviceTypes::BROWSER
      end

      before do
        request.threeds_v2_control_device_type      = device_type
        request.threeds_v2_browser_accept_header    = '*/*'
        request.threeds_v2_browser_java_enabled     = false
        request.threeds_v2_browser_language         = 'en-GB'
        request.threeds_v2_browser_color_depth      = 48
        request.threeds_v2_browser_screen_height    = 400
        request.threeds_v2_browser_screen_width     = 400
        request.threeds_v2_browser_time_zone_offset = '+0'
        request.threeds_v2_browser_user_agent       = Faker::Internet.user_agent
      end

      it 'contains force_threeds as direct child of payment_transaction' do
        document = Nokogiri::XML request.build_document

        expect(document.xpath('/payment_transaction/force_threeds').map(&:text)).to eq ['true']
      end

      it 'contains threeds_v2_params as direct child of payment_transaction' do
        document = Nokogiri::XML request.build_document

        expect(document.xpath('/payment_transaction/threeds_v2_params').size).to eq 1
      end
    end
  end
end
