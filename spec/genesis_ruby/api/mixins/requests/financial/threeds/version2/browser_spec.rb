# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/browser_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Browser do
  let(:browser) { GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::BrowserStub.new }

  describe 'when threeds_v2_browser_accept_header' do
    it 'with valid header' do
      browser.threeds_v2_browser_accept_header = header = 'text/plain'

      expect(browser.threeds_v2_browser_accept_header).to eq header
    end

    it 'with empty header' do
      browser.threeds_v2_browser_accept_header = ''

      expect(browser.threeds_v2_browser_accept_header).to eq nil
    end

    it 'with invalid header' do
      expect do
        browser.threeds_v2_browser_accept_header = Faker::String.random length: 2049
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_browser_java_enabled' do
    it 'with setter' do
      expect { browser.threeds_v2_browser_java_enabled = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      browser.threeds_v2_browser_java_enabled = flag = true

      expect(browser.threeds_v2_browser_java_enabled).to eq flag
    end

    it 'with empty flag' do
      browser.threeds_v2_browser_java_enabled = ''

      expect(browser.threeds_v2_browser_java_enabled).to eq ''
    end
  end

  describe 'when threeds_v2_browser_language' do
    it 'with valid language' do
      browser.threeds_v2_browser_language = language = 'en-GB'

      expect(browser.threeds_v2_browser_language).to eq language
    end

    it 'with empty language' do
      browser.threeds_v2_browser_language = ''

      expect(browser.threeds_v2_browser_language).to eq nil
    end

    it 'with invalid language' do
      expect do
        browser.threeds_v2_browser_language = Faker::String.random length: 9
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_color_depth' do
    it 'with setter' do
      expect { browser.threeds_v2_browser_color_depth = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      browser.threeds_v2_browser_color_depth = depth = 24

      expect(browser.threeds_v2_browser_color_depth).to eq depth
    end

    it 'with empty depth' do
      browser.threeds_v2_browser_color_depth = ''

      expect(browser.threeds_v2_browser_color_depth).to eq ''
    end
  end

  describe 'when threeds_v2_browser_screen_height' do
    it 'with integer height' do
      browser.threeds_v2_browser_screen_height = height = 240

      expect(browser.threeds_v2_browser_screen_height).to eq height
    end

    it 'with string height' do
      browser.threeds_v2_browser_screen_height = height = '240'

      expect(browser.threeds_v2_browser_screen_height).to eq height.to_i
    end

    it 'with empty height' do
      browser.threeds_v2_browser_screen_height = ''

      expect(browser.threeds_v2_browser_screen_height).to eq nil
    end
  end

  describe 'when threeds_v2_browser_screen_width' do
    it 'with integer width' do
      browser.threeds_v2_browser_screen_width = width = 640

      expect(browser.threeds_v2_browser_screen_width).to eq width
    end

    it 'with string width' do
      browser.threeds_v2_browser_screen_width = width = '640'

      expect(browser.threeds_v2_browser_screen_width).to eq width.to_i
    end

    it 'with empty width' do
      browser.threeds_v2_browser_screen_width = ''

      expect(browser.threeds_v2_browser_screen_width).to eq nil
    end
  end

  describe 'when threeds_v2_browser_time_zone_offset' do
    it 'with valid offset' do
      browser.threeds_v2_browser_time_zone_offset = offset = -120

      expect(browser.threeds_v2_browser_time_zone_offset).to eq offset.to_s
    end

    it 'with empty offset' do
      browser.threeds_v2_browser_time_zone_offset = ''

      expect(browser.threeds_v2_browser_time_zone_offset).to eq nil
    end

    it 'with invalid offset' do
      expect do
        browser.threeds_v2_browser_time_zone_offset = Faker::String.random length: 6
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_browser_user_agent' do
    it 'with valid agent' do
      browser.threeds_v2_browser_user_agent = agent = Faker::Internet.user_agent

      expect(browser.threeds_v2_browser_user_agent).to eq agent
    end

    it 'with empty agent' do
      browser.threeds_v2_browser_user_agent = ''

      expect(browser.threeds_v2_browser_user_agent).to eq nil
    end

    it 'with invalid agent' do
      expect do
        browser.threeds_v2_browser_user_agent = Faker::String.random length: 2049
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(browser.browser_attributes).to_not be_empty
  end

  it 'with field value validations structure' do
    expect(browser.threeds_browser_field_validations).to_not be_empty
  end
end
