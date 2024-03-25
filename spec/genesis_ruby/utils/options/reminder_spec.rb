require 'genesis_ruby/utils/options/reminder'
require 'genesis_ruby/api/constants/transactions/parameters/wpf/reminder_channels'

RSpec.describe GenesisRuby::Utils::Options::Reminder do
  let(:reminder) { described_class.new }
  let(:after) { Faker::Number.positive from: 1, to: 31 }
  let(:channel) { GenesisRuby::Api::Constants::Transactions::Parameters::Wpf::ReminderChannels.all.sample }

  it 'with invalid key' do
    expect { reminder.invalid = 'sms' }.to raise_error GenesisRuby::InvalidArgumentError
  end

  describe 'when channel' do
    it 'with valid key' do
      expect { reminder.channel = channel }.to_not raise_error
    end

    it 'with valid value' do
      reminder.channel = channel

      expect(reminder.channel).to eq channel
    end

    it 'with invalid value' do
      expect { reminder.channel = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when after' do
    it 'with valid key' do
      expect { reminder.after = after }.to_not raise_error
    end

    it 'with valid value' do
      reminder.after = after

      expect(reminder.after).to eq after
    end

    it 'with invalid value' do
      expect { reminder.after = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'with valid structure' do
    reminder.channel = channel
    reminder.after   = after

    expect(reminder).to eq({ channel: channel, after: after })
  end
end
