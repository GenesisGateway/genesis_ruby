# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/alternatives/alipay/site_information_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Alternatives::Alipay::SiteInformationAttributes do
  let(:site_information) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Alternatives::Alipay::SiteInformationAttributesStub.new
  end
  let(:site_types) { GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes }
  let(:url) { 'https://example.com' }
  let(:name) { 'Example' }

  # Assigns a value that the setter is expected to reject
  def assign_rejected(attribute, value)
    site_information.public_send "#{attribute}=", value
  rescue GenesisRuby::InvalidArgumentError
    nil
  end

  describe 'when new instance' do
    it 'with nil site_information_type' do
      expect(site_information.site_information_type).to be_nil
    end

    it 'with nil site_information_url' do
      expect(site_information.site_information_url).to be_nil
    end

    it 'with nil site_information_name' do
      expect(site_information.site_information_name).to be_nil
    end
  end

  describe 'when site_information_type' do
    it 'with setter' do
      expect { site_information.site_information_type = site_types::WEB }.to_not raise_error
    end

    it 'with getter' do
      site_information.site_information_type = site_types::APP

      expect(site_information.site_information_type).to eq site_types::APP
    end

    %w(DESKTOP web).push(nil, '').each do |value|
      it "with arbitrary value #{value.inspect} stored unchanged" do
        site_information.site_information_type = value

        expect(site_information.site_information_type).to eq value
      end
    end
  end

  describe 'when site_information_url' do
    it 'with setter' do
      expect { site_information.site_information_url = url }.to_not raise_error
    end

    it 'with getter' do
      site_information.site_information_url = url

      expect(site_information.site_information_url).to eq url
    end

    it 'with http scheme' do
      site_information.site_information_url = 'http://example.com'

      expect(site_information.site_information_url).to eq 'http://example.com'
    end

    it 'with long url without length restriction' do
      long_url = "https://example.com/#{"a" * 300}"
      site_information.site_information_url = long_url

      expect(site_information.site_information_url).to eq long_url
    end

    %w(ftp://example.com example.com https://).each do |value|
      it "with invalid url #{value}" do
        expect { site_information.site_information_url = value }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it "with invalid url #{value} keeps the previous value" do
        site_information.site_information_url = url
        assign_rejected :site_information_url, value

        expect(site_information.site_information_url).to eq url
      end
    end

    [nil, ''].each do |value|
      it "with #{value.inspect} after a previous value stores nil" do
        site_information.site_information_url = url
        site_information.site_information_url = value

        expect(site_information.site_information_url).to be_nil
      end
    end
  end

  describe 'when site_information_name' do
    it 'with setter' do
      expect { site_information.site_information_name = name }.to_not raise_error
    end

    it 'with getter' do
      site_information.site_information_name = name

      expect(site_information.site_information_name).to eq name
    end

    it 'with exactly 512 characters' do
      value = 'a' * 512
      site_information.site_information_name = value

      expect(site_information.site_information_name).to eq value
    end

    it 'with 513 characters' do
      expect { site_information.site_information_name = 'a' * 513 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with 513 characters keeps the previous value' do
      site_information.site_information_name = name
      assign_rejected :site_information_name, 'a' * 513

      expect(site_information.site_information_name).to eq name
    end

    [nil, ''].each do |value|
      it "with #{value.inspect} after a previous value stores nil" do
        site_information.site_information_name = name
        site_information.site_information_name = value

        expect(site_information.site_information_name).to be_nil
      end
    end
  end

  describe 'when site_information_structure' do
    it 'with Hash type' do
      expect(site_information.site_information_structure).to be_a Hash
    end

    it 'with exactly type, url and name keys' do
      expect(site_information.site_information_structure.keys).to contain_exactly :type, :url, :name
    end

    it 'with nil values when unset' do
      expect(site_information.site_information_structure).to eq({ type: nil, url: nil, name: nil })
    end

    it 'with assigned values' do
      site_information.site_information_type = site_types::WEB
      site_information.site_information_url  = url
      site_information.site_information_name = name

      expect(site_information.site_information_structure).to eq({ type: site_types::WEB, url: url, name: name })
    end
  end

  describe 'when site_information_field_validations' do
    it 'with Hash type' do
      expect(site_information.site_information_field_validations).to be_a Hash
    end

    it 'with site types allowed values' do
      expect(site_information.site_information_field_validations).to eq({ site_information_type: site_types.all })
    end
  end

  describe 'when no request-level validation in the mixin' do
    let(:mixin_methods) do
      described_class.instance_methods(false) +
        described_class.protected_instance_methods(false) +
        described_class.private_instance_methods(false)
    end

    it 'with no validation methods defined' do
      expect(mixin_methods).to_not include(
        :init_field_validations, :required_fields, :field_values, :field_value_dependencies, :validate
      )
    end

    it 'with no AttributeValidation in the stub ancestors' do
      expect(site_information.class.ancestors).to_not include GenesisRuby::Api::Mixins::Requests::AttributeValidation
    end

    it 'with invalid type and unset url raises no error' do
      site_information.site_information_type = 'DESKTOP'

      expect do
        site_information.site_information_structure
        site_information.site_information_field_validations
      end.to_not raise_error
    end

    it 'with invalid type and unset url returns the stored values' do
      site_information.site_information_type = 'DESKTOP'

      expect(site_information.site_information_structure).to eq({ type: 'DESKTOP', url: nil, name: nil })
    end
  end
end
