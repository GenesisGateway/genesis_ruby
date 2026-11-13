# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Alternatives::Alipay::RegisterMerchant do
  let(:test_required_fields) { %i[merchant_type site_information_type site_information_url contact_number] }
  let(:test_required_field_values) { %i[merchant_type site_information_type] }
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
    alipay_constants = GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay
    request          = described_class.new config

    request.merchant_type         = alipay_constants::MerchantTypes::INDIVIDUAL
    request.site_information_type = alipay_constants::SiteTypes::WEB
    request.site_information_url  = 'https://example.com'
    request.contact_number        = '1234567'
    request.representative_name   = 'Your Name'
    request.representative_id     = '1234567'

    request
  end

  it_behaves_like 'site information attributes examples'
  it_behaves_like 'versioned request examples'

  include_examples 'base request examples'

  describe 'when class definition' do
    it 'with versioned superclass' do
      expect(described_class.superclass).to eq GenesisRuby::Api::Requests::Base::Versioned
    end

    it 'with site information attributes' do
      expect(described_class.ancestors)
        .to include GenesisRuby::Api::Mixins::Requests::NonFinancial::Alternatives::Alipay::SiteInformationAttributes
    end
  end

  describe 'when initialized with configuration only' do
    let(:request) { described_class.new config }

    it 'with json builder interface' do
      expect(request.instance_variable_get('@builder_interface')).to eq GenesisRuby::Builder::JSON
    end

    it 'with v1 version' do
      expect(request.version).to eq 'v1'
    end

    it 'with v1 allowed versions only' do
      expect(request.allowed_versions).to eq ['v1']
    end

    it 'with register merchant request path' do
      expect(request.__send__(:request_path)).to eq 'alipay/register_merchant'
    end
  end

  describe 'when service url' do
    [
      {
        environment: GenesisRuby::Api::Constants::Environments::STAGING,
        endpoint:    GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY,
        url:         'https://staging.gate.emerchantpay.net:443/v1/alipay/register_merchant/example_token/'
      },
      {
        environment: GenesisRuby::Api::Constants::Environments::PRODUCTION,
        endpoint:    GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY,
        url:         'https://gate.emerchantpay.net:443/v1/alipay/register_merchant/example_token/'
      },
      {
        environment: GenesisRuby::Api::Constants::Environments::STAGING,
        endpoint:    GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING,
        url:         'https://staging.gate.e-comprocessing.net:443/v1/alipay/register_merchant/example_token/'
      },
      {
        environment: GenesisRuby::Api::Constants::Environments::PRODUCTION,
        endpoint:    GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING,
        url:         'https://gate.e-comprocessing.net:443/v1/alipay/register_merchant/example_token/'
      }
    ].each do |example|
      describe "with #{example[:environment]} environment and #{example[:endpoint]} endpoint" do
        it 'with terminal token service url' do
          config.environment = example[:environment]
          config.endpoint    = example[:endpoint]

          expect(described_class.new(config).api_config.url).to eq example[:url]
        end
      end
    end

    describe 'with endpoint not set' do
      it 'raises endpoint not set error' do
        expect { described_class.new GenesisRuby::Configuration.new }.to raise_error GenesisRuby::EndpointNotSetError
      end
    end

    describe 'with empty terminal token' do
      before do
        config.token = ''
      end

      it 'does not raise error' do
        expect { described_class.new config }.to_not raise_error
      end

      it 'without token segment and trailing slash' do
        expect(described_class.new(config).api_config.url)
          .to eq 'https://staging.gate.emerchantpay.net:443/v1/alipay/register_merchant'
      end
    end
  end

  describe 'when invalid version' do
    def assign_rejected_version(request, value)
      request.version = value
    rescue GenesisRuby::InvalidArgumentError
      nil
    end

    ['v2', '', nil].each do |invalid_version|
      describe "with #{invalid_version.inspect} version" do
        it 'raises invalid argument error' do
          expect { request.version = invalid_version }.to raise_error GenesisRuby::InvalidArgumentError
        end

        it 'keeps the v1 version' do
          assign_rejected_version request, invalid_version

          expect(request.version).to eq 'v1'
        end

        it 'keeps the service url' do
          url_before = request.api_config.url
          assign_rejected_version request, invalid_version

          expect(request.api_config.url).to eq url_before
        end
      end
    end
  end

  describe 'when api config' do
    it 'with POST type' do
      expect(request.api_config.type).to eq GenesisRuby::Api::Request::METHOD_POST
    end

    it 'with https protocol' do
      expect(request.api_config.protocol).to eq GenesisRuby::Api::Request::PROTOCOL_HTTPS
    end

    it 'with 443 port' do
      expect(request.api_config.port).to eq GenesisRuby::Api::Request::PORT_HTTPS
    end

    it 'with json format' do
      expect(request.api_config.format).to eq GenesisRuby::Builder::JSON
    end

    it 'with basic authorization' do
      expect(request.api_config.authorization).to eq GenesisRuby::Api::Request::AUTH_TYPE_BASIC
    end
  end

  describe 'when setters' do
    let(:request) { described_class.new config }

    def assign_rejected(request, field, value)
      request.public_send :"#{field}=", value
    rescue GenesisRuby::InvalidArgumentError
      nil
    end

    build_value = lambda do |kind, length|
      case kind
      when :phone then '1' * length
      when :email
        local_part = 'a' * (length - 12)
        "#{local_part}@example.com"
      else 'a' * length
      end
    end

    setter_table = {
      shareholder_id:          { max: 128, kind: :text },
      shareholder_name:        { max: 64, kind: :text },
      registration_number:     { max: 128, kind: :text },
      representative_name:     { max: 64, kind: :text },
      representative_id:       { max: 128, kind: :text },
      settlement_number:       { max: 64, kind: :alphanumeric },
      contact_number:          { max: 64, kind: :phone },
      contact_email:           { max: 128, kind: :email },
      customer_service_number: { max: 64, kind: :phone },
      customer_service_email:  { max: 128, kind: :email }
    }

    invalid_formats = {
      settlement_number:       ['ABC-123'],
      contact_number:          ['12 34', '12a4', "123\n"],
      customer_service_number: ['12 34', '12a4', "123\n"],
      contact_email:           ['user@example', '@example.com'],
      customer_service_email:  ['user@example', '@example.com']
    }

    ([:merchant_type] + setter_table.keys).each do |field|
      it "responds to #{field} getter" do
        expect(request).to respond_to field
      end

      it "responds to #{field} setter" do
        expect(request).to respond_to :"#{field}="
      end
    end

    describe 'with merchant_type' do
      ['UNKNOWN', 'enterprise', nil, ''].each do |value|
        it "stores #{value.inspect} unchanged" do
          request.merchant_type = value

          expect(request.merchant_type).to eq value
        end
      end
    end

    setter_table.each do |field, rule|
      describe "with #{field}" do
        max_value      = build_value.call(rule[:kind], rule[:max])
        too_long_value = build_value.call(rule[:kind], rule[:max] + 1)
        previous_value = build_value.call(rule[:kind], 13)

        it "stores a value of #{rule[:max]} characters" do
          request.public_send :"#{field}=", max_value

          expect(request.public_send(field)).to eq max_value
        end

        it "raises invalid argument error with #{rule[:max] + 1} characters" do
          expect { request.public_send :"#{field}=", too_long_value }.to raise_error GenesisRuby::InvalidArgumentError
        end

        it "keeps the previous value after #{rule[:max] + 1} characters" do
          request.public_send :"#{field}=", previous_value
          assign_rejected request, field, too_long_value

          expect(request.public_send(field)).to eq previous_value
        end

        it "keeps nil after #{rule[:max] + 1} characters when never set" do
          assign_rejected request, field, too_long_value

          expect(request.public_send(field)).to be_nil
        end

        [nil, ''].each do |empty_value|
          it "stores nil with #{empty_value.inspect} after a previous value" do
            request.public_send :"#{field}=", previous_value
            request.public_send :"#{field}=", empty_value

            expect(request.public_send(field)).to be_nil
          end
        end

        invalid_formats.fetch(field, []).each do |invalid_value|
          it "raises invalid argument error with #{invalid_value.inspect}" do
            expect { request.public_send :"#{field}=", invalid_value }
              .to raise_error GenesisRuby::InvalidArgumentError
          end

          it "keeps the previous value after #{invalid_value.inspect}" do
            request.public_send :"#{field}=", previous_value
            assign_rejected request, field, invalid_value

            expect(request.public_send(field)).to eq previous_value
          end

          it "keeps nil after #{invalid_value.inspect} when never set" do
            assign_rejected request, field, invalid_value

            expect(request.public_send(field)).to be_nil
          end
        end
      end
    end
  end

  describe 'when build document validation' do
    merchant_types = GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::MerchantTypes
    site_types     = GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes
    getters        = %i[
      merchant_type site_information_type site_information_url site_information_name shareholder_id
      shareholder_name registration_number representative_name representative_id settlement_number
      contact_number contact_email customer_service_number customer_service_email
    ]

    def enterprise(request)
      merchant_types              = GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::MerchantTypes
      request.merchant_type       = merchant_types::ENTERPRISE
      request.representative_name = nil
      request.representative_id   = nil
      request.shareholder_id      = 'Shareholder ID'
      request.shareholder_name    = 'Shareholder Name'
      request.registration_number = '7654321'
      request
    end

    def document_of(request)
      JSON.parse request.build_document
    end

    def build_rejected(request)
      request.build_document
    rescue GenesisRuby::ParameterError
      nil
    end

    describe 'with required parameters' do
      %i[merchant_type site_information_type site_information_url contact_number].each do |field|
        it "raises parameter error without #{field}" do
          request.public_send :"#{field}=", nil

          expect { request.build_document }.to raise_error GenesisRuby::ParameterError
        end
      end
    end

    describe 'with allowed values' do
      {
        merchant_type:         %w(PARTNERSHIP enterprise Enterprise),
        site_information_type: %w(DESKTOP web Web)
      }.each do |field, invalid_values|
        invalid_values.each do |invalid_value|
          it "raises parameter error with #{field} #{invalid_value.inspect}" do
            request.public_send :"#{field}=", invalid_value

            expect { request.build_document }.to raise_error GenesisRuby::ParameterError
          end
        end
      end
    end

    describe 'with merchant type dependencies' do
      %i[shareholder_id shareholder_name registration_number].each do |field|
        it "raises parameter error with ENTERPRISE merchant type without #{field}" do
          enterprise(request).public_send :"#{field}=", nil

          expect { request.build_document }.to raise_error GenesisRuby::ParameterError
        end
      end

      %i[representative_name representative_id].each do |field|
        it "raises parameter error with INDIVIDUAL merchant type without #{field}" do
          request.public_send :"#{field}=", nil

          expect { request.build_document }.to raise_error GenesisRuby::ParameterError
        end
      end
    end

    describe 'with valid parameters' do
      it 'builds INDIVIDUAL merchant type without shareholder and registration values' do
        expect { request.build_document }.to_not raise_error
      end

      it 'builds ENTERPRISE merchant type without representative values' do
        expect { enterprise(request).build_document }.to_not raise_error
      end

      it 'builds INDIVIDUAL merchant type with shareholder values' do
        request.shareholder_id   = 'Shareholder ID'
        request.shareholder_name = 'Shareholder Name'

        expect(document_of(request)).to include 'shareholder_id'   => 'Shareholder ID',
                                                'shareholder_name' => 'Shareholder Name'
      end

      it 'builds ENTERPRISE merchant type with representative values' do
        enterprise(request).representative_name = 'Your Name'
        request.representative_id               = '1234567'

        expect(document_of(request)).to include 'representative_name' => 'Your Name',
                                                'representative_id'   => '1234567'
      end
    end

    describe 'with validation wiring' do
      it 'with required fields' do
        expect(request.__send__(:required_fields))
          .to eq %i[merchant_type site_information_type site_information_url contact_number]
      end

      it 'with field values' do
        expect(request.__send__(:field_values)).to eq merchant_type:         %w(ENTERPRISE INDIVIDUAL),
                                                      site_information_type: %w(APP WEB)
      end

      it 'with field value dependencies' do
        expect(request.__send__(:field_value_dependencies)).to eq merchant_type: {
          'ENTERPRISE' => %i[shareholder_id shareholder_name registration_number],
          'INDIVIDUAL' => %i[representative_name representative_id]
        }
      end
    end

    describe 'with parameter error recovery' do
      [
        { field: :merchant_type, invalid: 'PARTNERSHIP', valid: merchant_types::INDIVIDUAL },
        { field: :merchant_type, invalid: 'individual', valid: merchant_types::INDIVIDUAL },
        { field: :site_information_type, invalid: 'DESKTOP', valid: site_types::WEB },
        { field: :site_information_url, invalid: nil, valid: 'https://example.com' },
        { field: :contact_number, invalid: nil, valid: '1234567' },
        { field: :representative_id, invalid: nil, valid: '1234567' }
      ].each do |example|
        failing_case = "#{example[:field]} #{example[:invalid].inspect}"

        it "keeps every parameter value after failing with #{failing_case}" do
          request.public_send :"#{example[:field]}=", example[:invalid]
          values_before = getters.to_h { |getter| [getter, request.public_send(getter)] }
          build_rejected request

          expect(getters.to_h { |getter| [getter, request.public_send(getter)] }).to eq values_before
        end

        it "builds after correcting only #{failing_case}" do
          request.public_send :"#{example[:field]}=", example[:invalid]
          build_rejected request
          request.public_send :"#{example[:field]}=", example[:valid]

          expect { request.build_document }.to_not raise_error
        end
      end
    end
  end

  describe 'when request document' do
    allowed_keys = %w(
      merchant_type site_information shareholder_id shareholder_name registration_number representative_name
      representative_id settlement_number contact_number contact_email customer_service_number customer_service_email
    )
    optional_values = {
      shareholder_id:          '  Shareholder ID  ',
      shareholder_name:        'Mixed Case Name',
      registration_number:     'REG-0001 a',
      settlement_number:       'AbC123',
      contact_email:           'User@Example.com',
      customer_service_number: '0123456789',
      customer_service_email:  'Support@Example.com'
    }
    fixture_path = "#{File.dirname(__FILE__)}/../../../../../fixtures/requests/" \
                   'alipay_register_merchant_enterprise.json'

    def document_of(request)
      JSON.parse request.build_document
    end

    enterprise_values = {
      merchant_type:         GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::MerchantTypes::ENTERPRISE,
      site_information_type: GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes::APP,
      site_information_url:  'https://example.com',
      site_information_name: 'Example',
      contact_number:        '1234567',
      registration_number:   '1234567',
      shareholder_id:        '1234567',
      shareholder_name:      'Your Name',
      representative_name:   nil,
      representative_id:     nil
    }

    def assign_values(request, values)
      values.each { |field, value| request.public_send :"#{field}=", value }
      request
    end

    def assign_all(request, values)
      request.site_information_name = 'Example'
      assign_values request, values
    end

    describe 'with document shape' do
      it 'is a single json object without root key' do
        expect(document_of(request)).to be_a(Hash).and include 'merchant_type' => 'INDIVIDUAL'
      end

      it 'with only the allowed top level keys when every parameter is set' do
        expect(document_of(assign_all(request, optional_values)).keys).to match_array allowed_keys
      end

      it 'with only type url and name site information keys when every parameter is set' do
        expect(document_of(assign_all(request, optional_values))['site_information'].keys)
          .to match_array %w(type url name)
      end

      it 'with exact minimal INDIVIDUAL top level keys' do
        expect(document_of(request).keys)
          .to match_array %w(merchant_type site_information contact_number representative_name representative_id)
      end

      it 'with exact minimal INDIVIDUAL site information keys' do
        expect(document_of(request)['site_information'].keys).to match_array %w(type url)
      end
    end

    describe 'with unset parameters' do
      it 'without null values' do
        expect(request.build_document).to_not include 'null'
      end

      it 'without empty string values' do
        expect(request.build_document).to_not include '""'
      end

      it 'without site information name key when set to empty string' do
        request.site_information_name = ''

        expect(document_of(request)['site_information']).to_not have_key 'name'
      end

      optional_values.each_key do |field|
        it "without #{field} key when set to empty string" do
          request.public_send :"#{field}=", ''

          expect(document_of(request)).to_not have_key field.to_s
        end
      end
    end

    describe 'with set parameters' do
      it 'with every value unchanged as json string' do
        document = document_of assign_all(request, optional_values)

        expect(document).to include optional_values.transform_keys(&:to_s)
      end

      it 'with site information values unchanged' do
        expect(document_of(assign_all(request, optional_values))['site_information'])
          .to eq 'type' => 'WEB', 'url' => 'https://example.com', 'name' => 'Example'
      end

      it 'with ENTERPRISE example equal to the fixture' do
        expected = JSON.parse File.open(fixture_path).read

        expect(document_of(assign_values(request, enterprise_values))).to eq expected
      end

      it 'with json special and non ascii characters unchanged' do
        request.shareholder_name = 'Jöhn "J" Doe'

        expect(document_of(request)['shareholder_name']).to eq 'Jöhn "J" Doe'
      end

      it 'with backslash unchanged' do
        request.shareholder_id = 'ID\\2024\\01'

        expect(document_of(request)['shareholder_id']).to eq 'ID\\2024\\01'
      end
    end
  end
end
