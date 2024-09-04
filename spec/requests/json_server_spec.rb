require 'rails_helper'

RSpec.describe 'Serving JSON with names and public keys' do
  before do
    User.create(username: 'janet', public_key: 'npub1wqkvr9k8j23jyuqyym9fcnyxjpxyanujxsmyvpl7kyntcm0meh7qecu2uh', public_key_hex: '6042d70377f8ae95c160a64cbe0f632578f0b53b2c76095449e7053be3e62213')
    User.create(username: 'thorsten', public_key: 'npub16jnp5jea8r36gn9lzttskum9m463thrcz3nxmjjfd2qurseucvsqejsdf7', public_key_hex: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
  end

  context 'when a request is made to nostr.json without params' do
    it 'eturns all names and keys' do
      get '/.well-known/nostr.json'
      json_response = "{\"names\":{\"janet\":\"6042d70377f8ae95c160a64cbe0f632578f0b53b2c76095449e7053be3e62213\",\"thorsten\":\"d4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320\"}}"
      expect(response.body).to eq(json_response)
    end
  end

  context 'when a request is made to nostr.json with a name param' do
    it 'returns just the name' do
      get '/.well-known/nostr.json?name=thorsten'
      json_response = "{\"names\":{\"thorsten\":\"d4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320\"}}"
      expect(response.body).to eq(json_response)
    end
  end

  context "when a name is requested that doesn't exist" do
    it 'returns an empty name hash' do
      get '/.well-known/nostr.json?name=maria'
      json_response = "{\"names\":{}}"
      expect(response.body).to eq(json_response)
    end
  end
end
