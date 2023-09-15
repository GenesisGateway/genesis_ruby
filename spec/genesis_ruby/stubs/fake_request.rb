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

      post '/wpf' do
        xml_response 200, 'gate_wpf_payment.xml'
      end

      private

      def xml_response(response_code, file_name)
        content_type :xml
        status response_code
        File.open("#{File.dirname(__FILE__)}/../fixtures/responses/#{file_name}", 'rb').read
      end

    end
  end
end
