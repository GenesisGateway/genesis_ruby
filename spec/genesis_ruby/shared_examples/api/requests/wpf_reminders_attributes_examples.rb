RSpec.shared_examples 'wpf reminders attributes examples' do
  describe 'when WPF Reminders' do
    it 'without reminders' do
      expect(request.build_document).to_not include 'reminders'
    end

    describe 'with reminders' do
      let(:reminder_request) do
        request.pay_later = true
        request.add_reminder channel: 'email', after: 1
        request.add_reminder channel: 'sms', after: 20

        request
      end

      it 'with request structure' do # rubocop:disable RSpec/ExampleLength
        expect(reminder_request.build_document).to include "  <reminders>\n" \
                                                           "    <reminder>\n" \
                                                           "      <channel>email</channel>\n" \
                                                           "      <after>1</after>\n" \
                                                           "    </reminder>\n" \
                                                           "    <reminder>\n" \
                                                           "      <channel>sms</channel>\n" \
                                                           "      <after>20</after>\n" \
                                                           "    </reminder>\n" \
                                                           "  </reminders>\n"
      end

      it 'without pay_later' do
        reminder_request.pay_later = false

        expect(reminder_request.build_document).to_not include 'reminders'
      end

      describe 'when lifetime' do
        let(:reminder_request) do
          request.lifetime  = 10
          request.pay_later = true
          request.add_reminder channel: 'email', after: 10
          request.add_reminder channel: 'email', after: 5

          request
        end

        it 'with equal after and lifetime' do
          expect { reminder_request.build_document }.to raise_error GenesisRuby::ParameterError
        end

        it 'with less lifetime than after' do
          reminder_request.lifetime = 5

          expect { reminder_request.build_document }.to raise_error GenesisRuby::ParameterError
        end

        it 'with greater lifetime than after  ' do
          reminder_request.lifetime = 11

          expect { reminder_request.build_document }.to_not raise_error
        end
      end
    end
  end
end
