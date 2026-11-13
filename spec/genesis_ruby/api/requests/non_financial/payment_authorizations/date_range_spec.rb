# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::PaymentAuthorizations::DateRange do
  let(:test_required_fields) { %i[scope] }
  let(:date) { '2023-01-01' }
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new config

    request.start_date = date
    request.end_date   = date
    request.page       = 1
    request.per_page   = 100
    request.scope      = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes::CARD_NOT_PRESENT

    request
  end

  describe 'when initialized' do
    it 'with staging endpoint url' do
      expect(request.api_config[:url])
        .to eq 'https://staging.gate.emerchantpay.net:443/payment_authorizations/by_date'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<payment_authorization_request>'
    end
  end

  describe 'when parameters are set' do
    it 'with auth_start_date' do
      request.auth_start_date = date

      expect(request.build_document).to include "<auth_start_date>#{date}</auth_start_date>"
    end

    it 'with auth_end_date' do
      request.auth_end_date = date

      expect(request.build_document).to include "<auth_end_date>#{date}</auth_end_date>"
    end
  end

  describe 'when date value with a time component' do
    it 'with start_date rendered as date only' do
      request.start_date = '2023-01-01 10:30:00'
      request.end_date   = '2023-01-05'

      expect(request.build_document).to include '<start_date>2023-01-01</start_date>'
    end

    it 'with end_date rendered as date only' do
      request.start_date = '2023-01-01'
      request.end_date   = '2023-01-02 18:45:00'

      expect(request.build_document).to include '<end_date>2023-01-02</end_date>'
    end

    it 'with auth_start_date rendered as date only' do
      request.auth_start_date = '2023-01-01 10:30:00'
      request.auth_end_date   = '2023-01-05'

      expect(request.build_document).to include '<auth_start_date>2023-01-01</auth_start_date>'
    end

    it 'with auth_end_date rendered as date only' do
      request.auth_start_date = '2023-01-01'
      request.auth_end_date   = '2023-01-02 18:45:00'

      expect(request.build_document).to include '<auth_end_date>2023-01-02</auth_end_date>'
    end
  end

  describe 'when start dates' do
    it 'passes with only start_date set' do
      request.start_date      = date
      request.auth_start_date = nil

      expect { request.build_document }.to_not raise_error
    end

    it 'passes with only auth_start_date set' do
      request.start_date      = nil
      request.auth_start_date = date

      expect { request.build_document }.to_not raise_error
    end

    it 'passes with both start dates set' do
      request.start_date      = date
      request.auth_start_date = date

      expect { request.build_document }.to_not raise_error
    end

    it 'raises when neither start date is set' do
      request.start_date      = nil
      request.auth_start_date = nil

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'does not raise an order error for a single-endpoint creation range' do
      request.start_date = date
      request.end_date   = nil

      expect { request.build_document }.to_not raise_error
    end

    it 'does not raise an order error for a single-endpoint auth range' do
      request.start_date      = nil
      request.auth_start_date = date
      request.auth_end_date   = nil

      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when date order' do
    it 'with start_date and end_date on the same day with a later start time' do
      request.start_date = '2023-01-01 18:45:00'
      request.end_date   = '2023-01-01 09:15:00'

      expect { request.build_document }.to_not raise_error
    end

    it 'with end_date later than start_date' do
      request.start_date = '2023-01-01'
      request.end_date   = '2023-01-05'

      expect { request.build_document }.to_not raise_error
    end

    it 'with end_date earlier than start_date' do
      request.start_date = '2023-02-01'
      request.end_date   = '2023-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with auth_start_date and auth_end_date on the same day with a later start time' do
      request.start_date      = nil
      request.auth_start_date = '2023-01-01 18:45:00'
      request.auth_end_date   = '2023-01-01 09:15:00'

      expect { request.build_document }.to_not raise_error
    end

    it 'with auth_end_date later than auth_start_date' do
      request.start_date      = nil
      request.auth_start_date = '2023-01-01'
      request.auth_end_date   = '2023-01-05'

      expect { request.build_document }.to_not raise_error
    end

    it 'with auth_end_date earlier than auth_start_date' do
      request.start_date      = nil
      request.auth_start_date = '2023-02-01'
      request.auth_end_date   = '2023-01-01'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when per_page' do
    it 'with maximum value' do
      request.per_page = described_class::MAX_PER_PAGE

      expect(request.build_document).to include "<per_page>#{described_class::MAX_PER_PAGE}</per_page>"
    end

    it 'with value above the maximum' do
      request.per_page = described_class::MAX_PER_PAGE + 1

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when invalid dates' do
    it 'with invalid start_date' do
      expect { request.start_date = 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid end_date' do
      expect { request.end_date = 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid auth_start_date' do
      expect { request.auth_start_date = 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid auth_end_date' do
      expect { request.auth_end_date = 'not-a-date' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  include_examples 'base request examples'
  include_examples 'date attributes examples'
  include_examples 'paging attributes examples'
  include_examples 'scope attributes examples'
end
