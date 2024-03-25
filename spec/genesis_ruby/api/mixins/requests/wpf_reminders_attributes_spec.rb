require 'spec/genesis_ruby/stubs/api/requests/wpf_reminders_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::WpfRemindersAttributes do
  let(:wpf_reminders) { GenesisSpec::Stubs::Api::Requests::WpfRemindersAttributesStub.new }
  let(:reminder_language) { GenesisRuby::Api::Constants::I18n.all.sample }
  let(:reminder_channel) { GenesisRuby::Api::Constants::Transactions::Parameters::Wpf::ReminderChannels.all.sample }
  let(:reminder_after) { Faker::Number.positive from: 1, to: 31 * 24 * 60 }

  describe 'when reminder language' do
    it 'with setter' do
      expect { wpf_reminders.reminder_language = reminder_language }.to_not raise_error
    end

    it 'with getter' do
      wpf_reminders.reminder_language = reminder_language.upcase

      expect(wpf_reminders.reminder_language).to eq reminder_language
    end

    it 'with invalid value' do
      expect { wpf_reminders.reminder_language = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when add reminder' do
    it 'with valid values' do
      expect { wpf_reminders.add_reminder channel: reminder_channel, after: reminder_after }.to_not raise_error
    end

    it 'with invalid channel' do
      expect { wpf_reminders.add_reminder channel: 'invalid', after: reminder_after }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid after' do
      expect { wpf_reminders.add_reminder channel: reminder_channel, after: 32 * 24 * 60 }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with reminder structure' do
      wpf_reminders.add_reminder channel: reminder_channel, after: reminder_after

      expect(wpf_reminders.__send__(:reminders_structure))
        .to eq [{ reminder: { channel: reminder_channel, after: reminder_after } }]
    end

    it 'with init reminder' do
      expect(wpf_reminders.__send__(:init_reminder, channel: reminder_channel, after: reminder_after))
        .to be_kind_of GenesisRuby::Utils::Options::Reminder
    end

    describe 'when reminder count' do
      before do
        [1, 2, 3].each do
          wpf_reminders.add_reminder channel: reminder_channel, after: reminder_after
        end
      end

      it 'with valid reminders count' do
        expect(wpf_reminders.__send__(:reminders_structure).count).to eq 3
      end

      it 'with invalid reminders count' do
        expect do
          wpf_reminders.add_reminder channel: reminder_channel, after: reminder_after
        end.to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end
end
