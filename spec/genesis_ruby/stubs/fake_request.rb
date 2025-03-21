require 'sinatra/base'

module GenesisSpec
  module Stubs
    # Sinatra router for fake requests
    class FakeRequest < Sinatra::Base

      # Route example.com
      post '/success_example' do
        xml_response 200, 'common_error.xml'
      end

      post '/error_example' do
        xml_response 400, 'common_error.xml'
      end

      post '/error_example_without_body' do
        content_type :html
        status 422
      end

      post '/wpf' do
        xml_response 200, 'gate_wpf_payment.xml'
      end

      put '/method_continue' do
        xml_response 200, 'method_continue.xml'
      end

      put '/threeds/threeds_method/123' do
        xml_response 200, 'method_continue.xml'
      end

      post '/html_error' do
        content_type :html
        status 404
        File.open("#{File.dirname(__FILE__)}/../fixtures/responses/404.html")
      end

      post '/reconcile/api_transaction/' do
        xml_response 200, 'reconcile_api.xml'
      end

      post '/wpf/reconcile' do
        xml_response 200, 'reconcile_wpf.xml'
      end

      post '/process/example_token/' do
        xml_response 200, 'gate_authorize_payment_response.xml'
      end

      post '/reconcile/error_reconcile/' do
        xml_response 200, 'reconcile_error.xml'
      end

      get '/success_example' do
        json_response 200, 'billing_api_response.json'
      end

      get '/error_example' do
        json_response 400, 'gate_json_error_response.json'
      end

      post '/v1/installments' do
        json_response 200, 'billing_api_response.json'
      end

      get '/v1/installments/123' do
        json_response 200, 'billing_api_response.json'
      end

      private

      def xml_response(response_code, file_name)
        content_type :xml
        status response_code

        retrieve_fixture file_name
      end

      def json_response(response_code, file_name)
        content_type :json
        status response_code

        retrieve_fixture file_name
      end

      def retrieve_fixture(file_name)
        File.open("#{File.dirname(__FILE__)}/../fixtures/responses/#{file_name}", 'rb').read
      end

    end
  end
end
