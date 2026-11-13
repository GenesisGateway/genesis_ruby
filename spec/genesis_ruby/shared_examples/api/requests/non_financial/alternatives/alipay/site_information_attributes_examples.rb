# frozen_string_literal: true

RSpec.shared_examples 'site information attributes examples' do
  describe 'when site information attributes' do
    let(:site_information_type) { GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes::APP }
    let(:site_information_url) { 'https://example.com' }
    let(:site_information_name) { 'Example' }
    let(:site_information) do
      request.site_information_type = site_information_type
      request.site_information_url  = site_information_url
      request.site_information_name = site_information_name

      request
    end
    let(:site_information_document) { JSON.parse(site_information.build_document)['site_information'] }

    it 'with site_information type' do
      expect(site_information_document['type']).to eq site_information_type
    end

    it 'with site_information url' do
      expect(site_information_document['url']).to eq site_information_url
    end

    it 'with site_information name' do
      expect(site_information_document['name']).to eq site_information_name
    end

    it 'with exactly the site_information type, url and name keys' do
      expect(site_information_document.keys).to match_array %w(type url name)
    end

    it 'with WEB site_information type' do
      web = GenesisRuby::Api::Constants::NonFinancial::Alternatives::Alipay::SiteTypes::WEB
      site_information.site_information_type = web

      expect(site_information_document['type']).to eq web
    end

    it 'without site_information name' do
      site_information.site_information_name = nil

      expect(site_information_document).to_not have_key 'name'
    end

    it 'with invalid site_information type' do
      site_information.site_information_type = 'DESKTOP'

      expect { site_information.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end
end
