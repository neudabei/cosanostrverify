require 'rails_helper'

RSpec.describe User do
  describe 'validate username only uses characters a-z0-9-_.' do
    context 'when a username contains illegal characters' do
      it 'rejects the username' do
        user = User.new(username: 'golden$.dog', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_falsey
      end
    end

    context 'when a username has less than 2 characters' do
      it 'rejects the username' do
        user = User.new(username: 'g', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_falsey
      end
    end

    context 'when a username has more than 30 characters' do
      it 'rejects the username' do
        user = User.new(username: 'g' * 31, public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_falsey
      end
    end

    context 'when a username exists with different casing' do
      before do
        User.create(username: 'Hamburger', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
      end

      it 'rejects the username' do
        user = User.new(username: 'hamburger', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_falsey
      end
    end

    context 'when a username contains acceptable characters' do
      it 'accepts username with a .' do
        user = User.new(username: 'firstname.lastname', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_truthy
      end

      it 'accepts username with a -' do
        user = User.new(username: 'firstname-lastname', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_truthy
      end

      it 'accepts username with a _' do
        user = User.new(username: 'firstname_lastname', public_key: 'd4a61a4b3d38e3a44cbf12d70b7365dd7515dc7814666dca496a81c1c33cc320')
        expect(user.valid?).to be_truthy
      end
    end
  end
end
