RSpec.describe Stn::SecurityToken do
  context 'with an invalid client' do
    before { expect(Stn.configuration).to receive(:client_id).and_return 'invalid-client' }

    it 'raises an exception' do
      expect { Stn::SecurityToken.create }.to raise_error Stn::Error
    end

    context 'with ActiveSupport::Notifications' do
      before { require 'active_support/notifications' }

      it 'sends a notification' do
        expect(ActiveSupport::Notifications).to receive(:instrument).and_call_original
        expect { Stn::SecurityToken.create }.to raise_error Stn::Error
      end
    end
  end

  context 'with valid credentials' do
    let(:token) { Stn::SecurityToken.create }

    it 'provides a valid access token' do
      expect(token.access_token).not_to be_empty
    end
  end
end
