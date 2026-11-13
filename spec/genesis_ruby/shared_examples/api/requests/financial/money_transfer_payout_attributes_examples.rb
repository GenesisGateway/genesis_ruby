# frozen_string_literal: true

RSpec.shared_examples 'money transfer payout attributes examples' do
  describe 'when money transfer payout attributes' do
    it 'without money transfer attributes' do
      expect(request.build_document).to_not include 'money_transfer'
    end

    describe 'when money transfer attributes document' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:money_transfer_type) { 'account_to_account' }
      let(:sender_account_number) { '1234567890' }
      let(:sender_birth_date) { '31-12-1990' }
      let(:service_provider_name) { 'Provider' }
      let(:sender_account_number_type) { 'iban' }
      let(:mt_source_of_funds) { 'credit' }
      let(:sender_type) { 'natural' }
      let(:sender_first_name) { 'John' }
      let(:sender_last_name) { 'Doe' }
      let(:sender_country) { 'GB' }
      let(:sender_city) { 'London' }
      let(:sender_zip_code) { 'SW1A 1AA' }
      let(:sender_address1) { '10 Downing Street' }
      let(:sender_state) { 'LN' }
      let(:receiver_type) { 'legal' }
      let(:receiver_first_name) { 'Jane' }
      let(:receiver_last_name) { 'Roe' }
      let(:receiver_country) { 'FR' }
      let(:receiver_city) { 'Paris' }
      let(:receiver_zip_code) { '75001' }
      let(:receiver_address1) { '1 Rue de Rivoli' }
      let(:receiver_state) { 'IDF' }
      let(:money_transfer) do
        request.money_transfer_type                  = money_transfer_type
        request.money_transfer_sender_account_number = sender_account_number

        request
      end

      it 'with type' do
        expect(money_transfer.build_document).to include "<type>#{money_transfer_type}</type>"
      end

      it 'with sender_account_number' do
        expect(money_transfer.build_document)
          .to include "<sender_account_number>#{sender_account_number}</sender_account_number>"
      end

      it 'with sender_birth_date' do
        money_transfer.money_transfer_sender_birth_date = sender_birth_date

        expect(money_transfer.build_document)
          .to include "<sender_birth_date>#{sender_birth_date}</sender_birth_date>"
      end

      it 'with service_provider_name' do
        money_transfer.money_transfer_service_provider_name = service_provider_name

        expect(money_transfer.build_document)
          .to include "<service_provider_name>#{service_provider_name}</service_provider_name>"
      end

      it 'with sender_account_number_type' do
        money_transfer.money_transfer_sender_account_number_type = sender_account_number_type

        expect(money_transfer.build_document)
          .to include "<sender_account_number_type>#{sender_account_number_type}</sender_account_number_type>"
      end

      it 'with source_of_funds' do
        money_transfer.money_transfer_source_of_funds = mt_source_of_funds

        expect(money_transfer.build_document).to include "<source_of_funds>#{mt_source_of_funds}</source_of_funds>"
      end

      describe 'when sender_address' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        before do
          money_transfer.money_transfer_sender_address_type       = sender_type
          money_transfer.money_transfer_sender_address_first_name = sender_first_name
          money_transfer.money_transfer_sender_address_last_name  = sender_last_name
          money_transfer.money_transfer_sender_address_country    = sender_country
          money_transfer.money_transfer_sender_address_city       = sender_city
          money_transfer.money_transfer_sender_address_zip_code   = sender_zip_code
          money_transfer.money_transfer_sender_address_address1   = sender_address1
          money_transfer.money_transfer_sender_address_state      = sender_state
        end

        it 'with sender_address node' do
          expect(money_transfer.build_document).to include '<sender_address>'
        end

        it 'with type' do
          expect(money_transfer.build_document).to include "<type>#{sender_type}</type>"
        end

        it 'with first_name' do
          expect(money_transfer.build_document).to include "<first_name>#{sender_first_name}</first_name>"
        end

        it 'with last_name' do
          expect(money_transfer.build_document).to include "<last_name>#{sender_last_name}</last_name>"
        end

        it 'with country' do
          expect(money_transfer.build_document).to include "<country>#{sender_country}</country>"
        end

        it 'with city' do
          expect(money_transfer.build_document).to include "<city>#{sender_city}</city>"
        end

        it 'with zip_code' do
          expect(money_transfer.build_document).to include "<zip_code>#{sender_zip_code}</zip_code>"
        end

        it 'with address1' do
          expect(money_transfer.build_document).to include "<address1>#{sender_address1}</address1>"
        end

        it 'with state' do
          expect(money_transfer.build_document).to include "<state>#{sender_state}</state>"
        end
      end

      describe 'when receiver' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        before do
          money_transfer.money_transfer_receiver_type       = receiver_type
          money_transfer.money_transfer_receiver_first_name = receiver_first_name
          money_transfer.money_transfer_receiver_last_name  = receiver_last_name
          money_transfer.money_transfer_receiver_country    = receiver_country
          money_transfer.money_transfer_receiver_city       = receiver_city
          money_transfer.money_transfer_receiver_zip_code   = receiver_zip_code
          money_transfer.money_transfer_receiver_address1   = receiver_address1
          money_transfer.money_transfer_receiver_state      = receiver_state
        end

        it 'with receiver node' do
          expect(money_transfer.build_document).to include '<receiver>'
        end

        it 'with type' do
          expect(money_transfer.build_document).to include "<type>#{receiver_type}</type>"
        end

        it 'with first_name' do
          expect(money_transfer.build_document).to include "<first_name>#{receiver_first_name}</first_name>"
        end

        it 'with last_name' do
          expect(money_transfer.build_document).to include "<last_name>#{receiver_last_name}</last_name>"
        end

        it 'with country' do
          expect(money_transfer.build_document).to include "<country>#{receiver_country}</country>"
        end

        it 'with city' do
          expect(money_transfer.build_document).to include "<city>#{receiver_city}</city>"
        end

        it 'with zip_code' do
          expect(money_transfer.build_document).to include "<zip_code>#{receiver_zip_code}</zip_code>"
        end

        it 'with address1' do
          expect(money_transfer.build_document).to include "<address1>#{receiver_address1}</address1>"
        end

        it 'with state' do
          expect(money_transfer.build_document).to include "<state>#{receiver_state}</state>"
        end
      end
    end
  end
end
