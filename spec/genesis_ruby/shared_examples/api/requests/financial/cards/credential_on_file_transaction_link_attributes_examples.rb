# frozen_string_literal: true

require 'nokogiri'

RSpec.shared_examples 'credential on file transaction link attributes examples' do
  let(:valid_link_id) { 'Ab3_dE-9fGhIjKlMnOpQ12' }
  let(:valid_cof_identifier) { 'MCC0123456789ABCDEF' }
  let(:link_id_xpath) { '/payment_transaction/credential_on_file_transaction_link_id' }
  let(:cof_identifier_xpath) { '/payment_transaction/credential_on_file_transaction_identifier' }

  # Parse the built request document
  def xml_doc(request)
    Nokogiri::XML(request.build_document)
  end

  # Texts of all elements matching the given XPath in the built request document
  def xml_texts(request, xpath)
    xml_doc(request).xpath(xpath).map(&:text)
  end

  # Configure the request in an allowed flow (UCOF) for credential_on_file_transaction_link_id
  def allow_link_id_flow(request)
    request.credential_on_file = GenesisRuby::Api::Constants::Transactions::Parameters::CredentialOnFiles::
        MERCHANT_UNSCHEDULED
  end

  # Assign an invalid link id and swallow the expected InvalidArgumentError
  def assign_invalid_link_id(request, value)
    request.credential_on_file_transaction_link_id = value
  rescue GenesisRuby::InvalidArgumentError
    nil
  end

  describe 'when credential_on_file_transaction_link_id' do
    describe 'with setter' do
      it 'has initial nil value' do
        expect(request.credential_on_file_transaction_link_id).to be_nil
      end

      it 'stores valid value unchanged' do
        request.credential_on_file_transaction_link_id = valid_link_id

        expect(request.credential_on_file_transaction_link_id).to eq valid_link_id
      end

      it 'preserves mixed letter case' do
        request.credential_on_file_transaction_link_id = value = 'aBcDeFgHiJkLmNoPqRsTuV'

        expect(request.credential_on_file_transaction_link_id).to eq value
      end

      it 'stores value containing - and _' do
        request.credential_on_file_transaction_link_id = value = '-_0123456789-_abcdef-_'

        expect(request.credential_on_file_transaction_link_id).to eq value
      end

      it 'stores nil when nil is assigned' do
        request.credential_on_file_transaction_link_id = valid_link_id
        request.credential_on_file_transaction_link_id = nil

        expect(request.credential_on_file_transaction_link_id).to be_nil
      end

      it 'stores nil when empty string is assigned' do
        request.credential_on_file_transaction_link_id = valid_link_id
        request.credential_on_file_transaction_link_id = ''

        expect(request.credential_on_file_transaction_link_id).to be_nil
      end

      [21, 23].each do |length|
        it "raises error with #{length} chars long value" do
          expect { request.credential_on_file_transaction_link_id = 'a' * length }
            .to raise_error GenesisRuby::InvalidArgumentError, /22/
        end

        it "keeps previous value with #{length} chars long value" do
          request.credential_on_file_transaction_link_id = valid_link_id

          expect { assign_invalid_link_id(request, 'a' * length) }
            .to_not change(request, :credential_on_file_transaction_link_id)
        end
      end

      [' ', '.', '@', 'Ж'].each do |char|
        it "raises error with 22 chars long value containing #{char.inspect}" do
          expect { request.credential_on_file_transaction_link_id = ('a' * 21) + char }
            .to raise_error GenesisRuby::InvalidArgumentError
        end

        it "keeps previous value with 22 chars long value containing #{char.inspect}" do
          request.credential_on_file_transaction_link_id = valid_link_id

          expect { assign_invalid_link_id(request, char + ('a' * 21)) }
            .to_not change(request, :credential_on_file_transaction_link_id)
        end
      end

      it 'raises error with non String value' do
        expect { request.credential_on_file_transaction_link_id = 1_234_567_890_123_456_789_012 }
          .to raise_error GenesisRuby::InvalidArgumentError, /String/
      end

      it 'keeps credential_on_file_transaction_identifier with invalid value' do
        request.credential_on_file_transaction_identifier = valid_cof_identifier

        expect { assign_invalid_link_id(request, 'a' * 21) }
          .to_not change(request, :credential_on_file_transaction_identifier)
      end
    end

    describe 'with XML document' do
      before { allow_link_id_flow(request) }

      it 'contains element with the same value' do
        request.credential_on_file_transaction_link_id = valid_link_id

        expect(xml_texts(request, link_id_xpath)).to eq [valid_link_id]
      end

      %w(
        Ab3_dE-9fGhIjKlMnOpQ12 aBcDeFgHiJkLmNoPqRsTuV ABCDEFGHIJKLMNOPQRSTUV abcdefghijklmnopqrstuv
        0123456789012345678901 ---------------------- ______________________ -_0123456789-_abcdef-_
        Zz9-Yy8_Xx7-Ww6_Vv5-Uu MCtxnLnk_2026-10-29_AB
      ).each do |link_id|
        it "contains element with the same value for #{link_id}" do
          request.credential_on_file_transaction_link_id = link_id

          expect(xml_texts(request, link_id_xpath)).to eq [link_id]
        end
      end

      it 'does not contain element with nil value' do
        request.credential_on_file_transaction_link_id = nil

        expect(xml_texts(request, '//credential_on_file_transaction_link_id')).to be_empty
      end

      it 'does not contain element when setter was never called' do
        expect(xml_texts(request, '//credential_on_file_transaction_link_id')).to be_empty
      end

      it 'does not contain element when empty string is assigned after valid value' do
        request.credential_on_file_transaction_link_id = valid_link_id
        request.credential_on_file_transaction_link_id = ''

        expect(xml_texts(request, '//credential_on_file_transaction_link_id')).to be_empty
      end
    end

    describe 'with credential_on_file_transaction_identifier' do
      before do
        allow_link_id_flow(request)

        request.credential_on_file_transaction_identifier = valid_cof_identifier
        request.credential_on_file_transaction_link_id    = valid_link_id
      end

      it 'keeps identifier when link id changes' do
        expect { request.credential_on_file_transaction_link_id = 'Zz9-Yy8_Xx7-Ww6_Vv5-Uu' }
          .to_not change(request, :credential_on_file_transaction_identifier)
      end

      it 'keeps link id when identifier changes' do
        expect { request.credential_on_file_transaction_identifier = 'ANOTHER0123456789XYZ' }
          .to_not change(request, :credential_on_file_transaction_link_id)
      end

      it 'contains identifier element with its value' do
        expect(xml_texts(request, cof_identifier_xpath)).to eq [valid_cof_identifier]
      end

      it 'contains link id element with its value' do
        expect(xml_texts(request, link_id_xpath)).to eq [valid_link_id]
      end

      it 'contains only identifier element when link id is nil' do
        request.credential_on_file_transaction_link_id = nil

        expect([xml_texts(request, cof_identifier_xpath), xml_texts(request, link_id_xpath)])
          .to eq [[valid_cof_identifier], []]
      end
    end

    describe 'without credential_on_file_transaction_identifier' do
      before { allow_link_id_flow(request) }

      it 'keeps nil identifier when link id is assigned' do
        expect { request.credential_on_file_transaction_link_id = valid_link_id }
          .to_not change(request, :credential_on_file_transaction_identifier)
      end

      it 'keeps nil link id when identifier is assigned' do
        expect { request.credential_on_file_transaction_identifier = valid_cof_identifier }
          .to_not change(request, :credential_on_file_transaction_link_id)
      end

      it 'contains only link id element when identifier is not set' do
        request.credential_on_file_transaction_link_id = valid_link_id

        expect([xml_texts(request, link_id_xpath), xml_texts(request, '//credential_on_file_transaction_identifier')])
          .to eq [[valid_link_id], []]
      end
    end

    describe 'with required fields' do
      before { allow_link_id_flow(request) }

      it 'does not require link id by default' do
        expect(request.__send__(:required_fields)).to_not include :credential_on_file_transaction_link_id
      end

      it 'does not require link id after assignment and build' do
        request.credential_on_file_transaction_link_id = valid_link_id
        request.build_document

        expect(request.__send__(:required_fields)).to_not include :credential_on_file_transaction_link_id
      end
    end
  end

  describe 'when credential_on_file_transaction_link_id flow validation' do
    recurring_types      = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types
    credential_on_files  = GenesisRuby::Api::Constants::Transactions::Parameters::CredentialOnFiles
    flow_link_id         = 'Ab3_dE-9fGhIjKlMnOpQ12'

    flow_recurring_types = [nil, recurring_types::INITIAL, recurring_types::MANAGED, recurring_types::SUBSEQUENT]
    flow_reference_ids   = [nil, '', 'ref-'.ljust(20, 'a')]
    flow_cofs            = [
      nil, credential_on_files::MERCHANT_UNSCHEDULED, credential_on_files::SUBSEQUENT_CUSTOMER_INITIATED
    ]
    flow_link_ids        = [flow_link_id, nil]

    # Expected outcome computed from the rule of Requirement 6, independently of the implementation
    expected_allowed = lambda do |recurring_type, reference_id, credential_on_file, link_id|
      link_id.nil? ||
        (recurring_type == recurring_types::SUBSEQUENT && reference_id.to_s.empty?) ||
        credential_on_file == credential_on_files::MERCHANT_UNSCHEDULED
    end

    # Values of the flow related attributes of the request
    def flow_attributes(request)
      [
        request.recurring_type, request.reference_id, request.credential_on_file,
        request.credential_on_file_transaction_link_id
      ]
    end

    # Build the request document and return the raised ParameterError (nil when the build succeeds)
    def build_parameter_error(request)
      request.build_document

      nil
    rescue GenesisRuby::ParameterError => e
      e
    end

    # Configure the flow related attributes of the request starting from its valid configuration
    def configure_flow(request, combination)
      recurring_type, reference_id, credential_on_file, link_id = combination
      recurring_types = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types

      request.recurring_type = recurring_type
      if recurring_type == recurring_types::MANAGED
        request.managed_recurring_mode = GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::
            Modes::AUTOMATIC
      end
      request.reference_id                           = reference_id
      request.credential_on_file                     = credential_on_file
      request.credential_on_file_transaction_link_id = link_id
    end

    flow_recurring_types.product(flow_reference_ids, flow_cofs, flow_link_ids).each do |combination|
      recurring_type, reference_id, credential_on_file, link_id = combination
      description = "with recurring_type #{recurring_type.inspect}, reference_id #{reference_id.inspect}, " \
                    "credential_on_file #{credential_on_file.inspect} and link_id #{link_id.inspect}"

      if expected_allowed.call(*combination)
        it "builds document #{description}", :aggregate_failures do
          configure_flow(request, combination)

          expect { request.build_document }.to_not raise_error
          expect(xml_texts(request, link_id_xpath)).to eq [link_id].compact
        end
      else
        it "raises ParameterError #{description}", :aggregate_failures do
          configure_flow(request, combination)

          expect { request.build_document }
            .to raise_error GenesisRuby::ParameterError, /credential_on_file_transaction_link_id/
          expect(flow_attributes(request)).to eq combination
        end
      end
    end

    describe 'with UCOF flow, valid link id and missing amount' do
      before do
        request.credential_on_file                     = credential_on_files::MERCHANT_UNSCHEDULED
        request.credential_on_file_transaction_link_id = flow_link_id
        request.amount                                 = nil
      end

      it 'raises ParameterError' do
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'raises ParameterError not related to link id' do
        expect(build_parameter_error(request).message).to_not match(/credential_on_file_transaction_link_id/)
      end
    end
  end

  describe 'when credential_on_file_transaction_link_id flow validation is re-evaluated' do
    recurring_types     = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types
    credential_on_files = GenesisRuby::Api::Constants::Transactions::Parameters::CredentialOnFiles
    link_id_error       = /credential_on_file_transaction_link_id/

    describe 'with non-referenced subsequent flow' do
      before do
        request.recurring_type                         = recurring_types::SUBSEQUENT
        request.credential_on_file_transaction_link_id = valid_link_id
      end

      it 'builds, fails after initial recurring type and builds again after subsequent', :aggregate_failures do
        expect { request.build_document }.to_not raise_error

        request.recurring_type = recurring_types::INITIAL
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, link_id_error

        request.recurring_type = recurring_types::SUBSEQUENT
        expect { request.build_document }.to_not raise_error
      end
    end

    describe 'with initial recurring type' do
      before do
        request.recurring_type                         = recurring_types::INITIAL
        request.credential_on_file_transaction_link_id = valid_link_id
      end

      it 'fails and builds after merchant unscheduled credential on file', :aggregate_failures do
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, link_id_error

        request.credential_on_file = credential_on_files::MERCHANT_UNSCHEDULED
        expect { request.build_document }.to_not raise_error
      end
    end

    describe 'with referenced subsequent flow' do
      before do
        request.recurring_type                         = recurring_types::SUBSEQUENT
        request.reference_id                           = 'ref-'.ljust(20, 'a')
        request.credential_on_file_transaction_link_id = valid_link_id
      end

      it 'fails and builds after reference id is removed', :aggregate_failures do
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, link_id_error

        request.reference_id = nil
        expect { request.build_document }.to_not raise_error
      end
    end

    describe 'with disallowed flow' do
      before { request.credential_on_file_transaction_link_id = valid_link_id }

      it 'fails and builds after link id is removed', :aggregate_failures do
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError, link_id_error

        request.credential_on_file_transaction_link_id = nil
        expect { request.build_document }.to_not raise_error
      end
    end
  end

  describe 'when credential_on_file_transaction_link_id is read after build_document' do
    # Build the request document and swallow the expected ParameterError
    def build_ignoring_parameter_error(request)
      request.build_document
    rescue GenesisRuby::ParameterError
      nil
    end

    describe 'with successful build' do
      before do
        request.credential_on_file = GenesisRuby::Api::Constants::Transactions::Parameters::CredentialOnFiles::
            MERCHANT_UNSCHEDULED
      end

      it 'keeps valid link id' do
        request.credential_on_file_transaction_link_id = valid_link_id

        expect { request.build_document }.to_not change(request, :credential_on_file_transaction_link_id)
      end

      it 'keeps nil link id' do
        request.credential_on_file_transaction_link_id = nil

        expect { request.build_document }.to_not change(request, :credential_on_file_transaction_link_id)
      end
    end

    describe 'with ParameterError build' do
      it 'keeps valid link id', :aggregate_failures do
        request.credential_on_file_transaction_link_id = valid_link_id

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
        expect { build_ignoring_parameter_error(request) }
          .to_not change(request, :credential_on_file_transaction_link_id).from(valid_link_id)
      end

      it 'keeps nil link id', :aggregate_failures do
        request.credential_on_file_transaction_link_id = nil
        request.amount                                 = nil

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
        expect { build_ignoring_parameter_error(request) }
          .to_not change(request, :credential_on_file_transaction_link_id).from(nil)
      end
    end
  end
end
