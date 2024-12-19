RSpec.describe 'A typical flow' do
  let(:token) { Stn::SecurityToken.create }
  before { Stn.configure { |config| config.access_token = token.access_token } }
  let(:zips) { Stn::Zip.all }

  it 'is successful' do
    expect(zips).to all be_a Stn::Zip
  end
end
