# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/credential_on_file_transaction_link_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::CredentialOnFileTransactionLinkAttributes do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::Cards::CredentialOnFileTransactionLinkAttributesStub.new
  end
  let(:valid_id)    { 'aB3-dE6_gH9-jK2_mN5-pQ' }
  let(:previous_id) { 'Zy0_Xw1-Vu2_Ts3-Rq4_Po' }
  let(:messages) do
    {
      type:    'credential_on_file_transaction_link_id accepts only String values',
      length:  'credential_on_file_transaction_link_id value must be exactly 22 chars long.',
      charset: 'credential_on_file_transaction_link_id accepts only Latin letters, digits, - and _ characters.'
    }
  end

  describe 'when accessors' do
    it 'with default value' do
      expect(attributes.credential_on_file_transaction_link_id).to be_nil
    end

    it 'with valid ID stored unchanged' do
      attributes.credential_on_file_transaction_link_id = valid_id

      expect(attributes.credential_on_file_transaction_link_id).to eq 'aB3-dE6_gH9-jK2_mN5-pQ'
    end

    it 'with nil value' do
      attributes.credential_on_file_transaction_link_id = valid_id
      attributes.credential_on_file_transaction_link_id = nil

      expect(attributes.credential_on_file_transaction_link_id).to be_nil
    end

    it 'with empty string value' do
      attributes.credential_on_file_transaction_link_id = valid_id
      attributes.credential_on_file_transaction_link_id = ''

      expect(attributes.credential_on_file_transaction_link_id).to be_nil
    end
  end

  describe 'when invalid value' do
    before do
      attributes.credential_on_file_transaction_link_id = previous_id
    end

    shared_examples 'rejected link id' do |value, message_key|
      it 'raises InvalidArgumentError with exact message' do
        expect { attributes.credential_on_file_transaction_link_id = value }
          .to raise_error GenesisRuby::InvalidArgumentError, messages[message_key]
      end

      it 'preserves the previous value' do # rubocop:disable RSpec/MultipleExpectations
        expect { attributes.credential_on_file_transaction_link_id = value }
          .to raise_error GenesisRuby::InvalidArgumentError
        expect(attributes.credential_on_file_transaction_link_id).to eq previous_id
      end
    end

    context 'with length 21' do
      include_examples 'rejected link id', 'a' * 21, :length
    end

    context 'with length 23' do
      include_examples 'rejected link id', 'a' * 23, :length
    end

    [' ', "\n", '.', '@', 'Ж'].each do |char|
      context "with 22 chars containing #{char.inspect}" do
        include_examples 'rejected link id', ('a' * 21) + char, :charset
      end
    end

    context 'with Integer' do
      include_examples 'rejected link id', 1_234_567_890_123_456_789_012, :type
    end

    context 'with 22 chars Symbol' do
      include_examples 'rejected link id', ('a' * 22).to_sym, :type
    end

    context 'with Array' do
      include_examples 'rejected link id', ['a' * 22], :type
    end

    context 'with Hash' do
      include_examples 'rejected link id', { id: 'a' * 22 }, :type
    end
  end

  describe 'when flow validation' do
    let(:flow_message) do
      'credential_on_file_transaction_link_id is allowed only with recurring_type subsequent without ' \
        'reference_id or with credential_on_file merchant_unscheduled'
    end

    it 'passes without link id' do
      expect { attributes.validate_credential_on_file_transaction_link_id }.to_not raise_error
    end

    context 'with link id' do
      before do
        attributes.credential_on_file_transaction_link_id = valid_id
      end

      it 'passes with non-referenced subsequent recurring type' do
        attributes.recurring_type = 'subsequent'

        expect { attributes.validate_credential_on_file_transaction_link_id }.to_not raise_error
      end

      it 'passes with merchant unscheduled credential on file' do
        attributes.credential_on_file = 'merchant_unscheduled'

        expect { attributes.validate_credential_on_file_transaction_link_id }.to_not raise_error
      end

      it 'fails with referenced subsequent recurring type' do
        attributes.recurring_type = 'subsequent'
        attributes.reference_id   = 'reference'

        expect { attributes.validate_credential_on_file_transaction_link_id }
          .to raise_error GenesisRuby::ParameterError, /#{Regexp.escape(flow_message)}/
      end

      it 'fails without allowed flow' do
        expect { attributes.validate_credential_on_file_transaction_link_id }
          .to raise_error GenesisRuby::ParameterError, /#{Regexp.escape(flow_message)}/
      end
    end
  end
end
