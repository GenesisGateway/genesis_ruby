require 'genesis_ruby/network/adapter/base_adapter'

RSpec.describe GenesisRuby::Network::Adapter::BaseAdapter do
  let(:base_adapter) { described_class.new }

  describe 'without implementation' do
    describe 'raise error' do
      it 'throws when status called' do
        expect { base_adapter.status }.to raise_error(NotImplementedError)
      end

      it 'throws when prepare_request called' do
        expect { base_adapter.prepare_request({}) }.to raise_error(NotImplementedError)
      end

      it 'throws when execute called' do
        expect { base_adapter.execute }.to raise_error(NotImplementedError)
      end
    end

    describe 'has predefined accessors' do
      it 'response_body attribute reader' do
        expect { base_adapter.response_body }.to_not raise_error
      end

      it 'response_body attribute writer' do
        expect { base_adapter.response_body = '<xml>' }.to_not raise_error
      end

      it 'response_headers attribute reader' do
        expect { base_adapter.response_headers }.to_not raise_error
      end

      it 'response_headers attribute writer' do
        expect { base_adapter.response_headers = {} }.to_not raise_error
      end
    end
  end
end
