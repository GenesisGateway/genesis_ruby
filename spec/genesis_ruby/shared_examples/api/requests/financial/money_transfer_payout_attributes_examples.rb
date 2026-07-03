# frozen_string_literal: true

RSpec.shared_examples 'money transfer payout attributes examples' do
  describe 'when money transfer payout attributes' do
    it 'without money transfer attributes' do
      expect(request.build_document).to_not include 'money_transfer'
    end

    describe 'when money transfer attributes document' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:money_transfer_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::Types.all.sample
      end
      let(:sender_account_number) { Faker::Internet.uuid }
      let(:sender_birth_date) { Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%d-%m-%Y') }
      let(:service_provider_name) { Faker::Company.name }
      let(:sender_account_number_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::SenderAccountNumberTypes.all.sample
      end
      let(:mt_purpose_of_payment) do
        GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::PurposeOfPayments.all.sample
      end
      let(:mt_source_of_funds) do
        GenesisRuby::Api::Constants::Transactions::Parameters::MoneyTransfer::SourceOfFunds.all.sample
      end
      let(:sender_country) { Faker::Address.country_code }
      let(:sender_city) { Faker::Address.city }
      let(:sender_line) { Faker::Address.street_address }
      let(:sender_state) { Faker::Address.state_abbr }
      let(:sender_postal_code) { Faker::Address.zip_code }
      let(:receiver_first_name) { Faker::Name.first_name }
      let(:receiver_last_name) { Faker::Name.last_name }
      let(:receiver_country) { Faker::Address.country_code }
      let(:receiver_city) { Faker::Address.city }
      let(:receiver_line) { Faker::Address.street_address }
      let(:receiver_state) { Faker::Address.state_abbr }
      let(:receiver_postal_code) { Faker::Address.zip_code }
      let(:receiver_account_number) { Faker::Internet.uuid }
      let(:receiver_account_number_type) { Faker::Lorem.word }
      let(:money_transfer) do
        request.money_transfer_type = money_transfer_type
        request.money_transfer_sender_account_number = sender_account_number

        request
      end

      it 'with valid type' do
        expect(money_transfer.build_document).to include "<type>#{money_transfer_type}</type>"
      end

      it 'with invalid type' do
        expect do
          money_transfer.money_transfer_type = 'invalid'
        end.to raise_error GenesisRuby::InvalidArgumentError
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

      it 'with valid sender_account_number_type' do
        money_transfer.money_transfer_sender_account_number_type = sender_account_number_type

        expect(money_transfer.build_document)
          .to include "<sender_account_number_type>#{sender_account_number_type}</sender_account_number_type>"
      end

      it 'with invalid sender_account_number_type' do
        expect do
          money_transfer.money_transfer_sender_account_number_type = 'invalid'
        end.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with valid purpose_of_payment' do
        money_transfer.money_transfer_purpose_of_payment = mt_purpose_of_payment

        expect(money_transfer.build_document)
          .to include "<purpose_of_payment>#{mt_purpose_of_payment}</purpose_of_payment>"
      end

      it 'with invalid purpose_of_payment' do
        expect do
          money_transfer.money_transfer_purpose_of_payment = 'invalid'
        end.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with valid source_of_funds' do
        money_transfer.money_transfer_source_of_funds = mt_source_of_funds

        expect(money_transfer.build_document)
          .to include "<source_of_funds>#{mt_source_of_funds}</source_of_funds>"
      end

      it 'with invalid source_of_funds' do
        expect do
          money_transfer.money_transfer_source_of_funds = 'invalid'
        end.to raise_error GenesisRuby::InvalidArgumentError
      end

      describe 'when sender_address' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        before do
          money_transfer.money_transfer_sender_address_country     = sender_country
          money_transfer.money_transfer_sender_address_city        = sender_city
          money_transfer.money_transfer_sender_address_line        = sender_line
          money_transfer.money_transfer_sender_address_state       = sender_state
          money_transfer.money_transfer_sender_address_postal_code = sender_postal_code
        end

        it 'with sender_address node' do
          expect(money_transfer.build_document).to include '<sender_address>'
        end

        it 'with country' do
          expect(money_transfer.build_document).to include "<country>#{sender_country}</country>"
        end

        it 'with city' do
          expect(money_transfer.build_document).to include "<city>#{sender_city}</city>"
        end

        it 'with line' do
          expect(money_transfer.build_document).to include "<line>#{sender_line}</line>"
        end

        it 'with state' do
          expect(money_transfer.build_document).to include "<state>#{sender_state}</state>"
        end

        it 'with postal_code' do
          expect(money_transfer.build_document).to include "<postal_code>#{sender_postal_code}</postal_code>"
        end
      end

      describe 'when receiver' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        before do
          money_transfer.money_transfer_receiver_first_name          = receiver_first_name
          money_transfer.money_transfer_receiver_last_name           = receiver_last_name
          money_transfer.money_transfer_receiver_address_country     = receiver_country
          money_transfer.money_transfer_receiver_address_city        = receiver_city
          money_transfer.money_transfer_receiver_address_line        = receiver_line
          money_transfer.money_transfer_receiver_address_state       = receiver_state
          money_transfer.money_transfer_receiver_address_postal_code = receiver_postal_code
          money_transfer.money_transfer_receiver_account_number      = receiver_account_number
          money_transfer.money_transfer_receiver_account_number_type = receiver_account_number_type
        end

        it 'with receiver node' do
          expect(money_transfer.build_document).to include '<receiver>'
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

        it 'with line' do
          expect(money_transfer.build_document).to include "<line>#{receiver_line}</line>"
        end

        it 'with state' do
          expect(money_transfer.build_document).to include "<state>#{receiver_state}</state>"
        end

        it 'with postal_code' do
          expect(money_transfer.build_document).to include "<postal_code>#{receiver_postal_code}</postal_code>"
        end

        it 'with account_number' do
          expect(money_transfer.build_document)
            .to include "<account_number>#{receiver_account_number}</account_number>"
        end

        it 'with account_number_type' do
          expect(money_transfer.build_document)
            .to include "<account_number_type>#{receiver_account_number_type}</account_number_type>"
        end
      end
    end
  end
end
