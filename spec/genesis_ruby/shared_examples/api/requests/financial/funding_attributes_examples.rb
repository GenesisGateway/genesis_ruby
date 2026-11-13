# frozen_string_literal: true

RSpec.shared_examples 'funding attributes examples' do
  describe 'when funding attributes' do
    it 'without funding attributes' do
      expect(request.build_document).to_not include 'funding'
    end

    describe 'when funding attributes document' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:identifier_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::Funding::IdentifierTypes.all.sample
      end
      let(:business_application_identifier) do
        GenesisRuby::Api::Constants::Transactions::Parameters::Funding::BusinessApplicationIdentifierTypes.all.sample
      end
      let(:first_name) { Faker::Name.first_name }
      let(:last_name) { Faker::Name.last_name }
      let(:country) { Faker::Address.country_code }
      let(:account_number) { Faker::Internet.uuid }
      let(:account_number_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::Funding::ReceiverAccountTypes.all.sample
      end
      let(:address) { Faker::Address.full_address }
      let(:address2) { Faker::Address.secondary_address }
      let(:street_name) { Faker::Address.street_name }
      let(:state) { Faker::Address.state }
      let(:city) { Faker::Address.city }
      let(:zip_code) { Faker::Address.zip_code }
      let(:receiver_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::Funding::PersonTypes.all.sample
      end
      let(:sender_type) do
        GenesisRuby::Api::Constants::Transactions::Parameters::Funding::PersonTypes.all.sample
      end
      let(:funding) do
        request.funding_identifier_type                 = identifier_type
        request.funding_business_application_identifier = business_application_identifier

        request
      end

      it 'with valid identifier_type' do
        expect(funding.build_document).to include "<identifier_type>#{identifier_type}</identifier_type>"
      end

      it 'with invalid identifier_type' do
        funding.funding_identifier_type = 'invalid'

        expect { funding.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with valid business_application_identifier' do
        expect(funding.build_document).to include '<business_application_identifier>' \
                                                  "#{business_application_identifier}</business_application_identifier>"
      end

      it 'with invalid business_application_identifier' do
        funding.funding_business_application_identifier = 'invalid'

        expect { funding.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'without type' do
        expect(funding.build_document).to_not include '<type>'
      end

      it 'without address2' do
        expect(funding.build_document).to_not include '<address2>'
      end

      it 'without street_name' do
        expect(funding.build_document).to_not include '<street_name>'
      end

      it 'without zip_code' do
        expect(funding.build_document).to_not include '<zip_code>'
      end

      describe 'when receiver' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        let(:init_receiver) do
          funding.funding_receiver_first_name          = first_name
          funding.funding_receiver_last_name           = last_name
          funding.funding_receiver_type                = receiver_type
          funding.funding_receiver_country             = country
          funding.funding_receiver_account_number      = account_number
          funding.funding_receiver_account_number_type = account_number_type
          funding.funding_receiver_address             = address
          funding.funding_receiver_address2            = address2
          funding.funding_receiver_street_name         = street_name
          funding.funding_receiver_state               = state
          funding.funding_receiver_city                = city
          funding.funding_receiver_zip_code            = zip_code
        end

        before { init_receiver }

        it 'with receiver node' do
          expect(funding.build_document).to include '<receiver>'
        end

        it 'with first_name' do
          expect(funding.build_document).to include "<first_name>#{first_name}</first_name>"
        end

        it 'with last_name' do
          expect(funding.build_document).to include "<last_name>#{last_name}</last_name>"
        end

        it 'with type' do
          expect(funding.build_document).to include "<type>#{receiver_type}</type>"
        end

        it 'with country' do
          expect(funding.build_document).to include "<country>#{country}</country>"
        end

        it 'with account_number' do
          expect(funding.build_document).to include "<account_number>#{account_number}</account_number>"
        end

        it 'with valid account_number_type' do
          expect(funding.build_document).to include "<account_number_type>#{account_number_type}</account_number_type>"
        end

        it 'with invalid account_number_type' do
          funding.funding_receiver_account_number_type = 'invalid'

          expect { funding.build_document }.to raise_error GenesisRuby::ParameterError
        end

        it 'with address' do
          expect(funding.build_document).to include "<address>#{address}</address>"
        end

        it 'with address2' do
          expect(funding.build_document).to include "<address2>#{address2}</address2>"
        end

        it 'with street_name' do
          expect(funding.build_document).to include "<street_name>#{street_name}</street_name>"
        end

        it 'with state' do
          expect(funding.build_document).to include "<state>#{state}</state>"
        end

        it 'with city' do
          expect(funding.build_document).to include "<city>#{city}</city>"
        end

        it 'with zip_code' do
          expect(funding.build_document).to include "<zip_code>#{zip_code}</zip_code>"
        end

        # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
        it 'with ordered receiver elements' do
          node      = funding.build_document[%r{<receiver>.*?</receiver>}m]
          order     = %w(first_name last_name type country account_number account_number_type address address2
                         street_name state city zip_code)
          positions = order.map { |element| node.index "<#{element}>" }

          expect(positions).to_not include nil
          expect(positions).to eq positions.sort
        end
        # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
      end

      describe 'when sender' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        let(:init_sender) do
          funding.funding_sender_name             = "#{first_name} #{last_name}"
          funding.funding_sender_type             = sender_type
          funding.funding_sender_reference_number = account_number
          funding.funding_sender_country          = country
          funding.funding_sender_address          = address
          funding.funding_sender_state            = state
          funding.funding_sender_city             = city
        end

        before { init_sender }

        it 'with sender node' do
          expect(funding.build_document).to include 'sender'
        end

        it 'with name' do
          expect(funding.build_document).to include "<name>#{first_name} #{last_name}</name>"
        end

        it 'with type' do
          expect(funding.build_document).to include "<type>#{sender_type}</type>"
        end

        it 'with reference_number' do
          expect(funding.build_document).to include "<reference_number>#{account_number}</reference_number>"
        end

        it 'with country' do
          expect(funding.build_document).to include "<country>#{country}</country>"
        end

        it 'with address' do
          expect(funding.build_document).to include "<address>#{address}</address>"
        end

        it 'with state' do
          expect(funding.build_document).to include "<state>#{state}</state>"
        end

        it 'with city' do
          expect(funding.build_document).to include "<city>#{city}</city>"
        end

        it 'with ordered sender elements' do # rubocop:disable RSpec/MultipleExpectations
          node      = funding.build_document[%r{<sender>.*?</sender>}m]
          order     = %w(name type reference_number country address state city)
          positions = order.map { |element| node.index "<#{element}>" }

          expect(positions).to_not include nil
          expect(positions).to eq positions.sort
        end
      end

      describe 'when non-enforcement' do # rubocop:disable RSpec/MultipleMemoizedHelpers
        it 'with receiver type and no names' do
          funding.funding_receiver_type = receiver_type

          expect { funding.build_document }.to_not raise_error
        end

        it 'with sender type and no name' do
          funding.funding_sender_type = sender_type

          expect { funding.build_document }.to_not raise_error
        end

        it 'with sparse receiver address' do
          funding.funding_receiver_type = receiver_type
          funding.funding_receiver_city = city

          expect { funding.build_document }.to_not raise_error
        end

        it 'without account_number and reference_number' do
          funding.funding_receiver_type = receiver_type
          funding.funding_sender_type   = sender_type

          expect { funding.build_document }.to_not raise_error
        end
      end
    end
  end
end
