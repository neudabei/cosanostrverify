require 'rails_helper'

RSpec.describe KeyConverterService do
  subject { described_class.new(submitted_key) }

  describe '#convert' do
    context 'when the submitted key starts with npub' do
      let(:submitted_key) { 'npub1wqkvr9k8j23jyuqyym9fcnyxjpxyanujxsmyvpl7kyntcm0meh7qecu2uh' }

      it 'is returned as a hash with the public key and the hex key' do
        expect(subject.convert).to eq({ public_key: submitted_key, public_key_hex: '702cc196c792a322700426ca9c4c86904c4ecf9234364607feb126bc6dfbcdfc' })
      end
    end

    context 'when the submitted key is in hex' do
      let(:submitted_key) { '702cc196c792a322700426ca9c4c86904c4ecf9234364607feb126bc6dfbcdfc' }

      it 'is returned as a hash with the public key and the hex key' do
        expect(subject.convert).to eq({ public_key: 'npub1wqkvr9k8j23jyuqyym9fcnyxjpxyanujxsmyvpl7kyntcm0meh7qecu2uh', public_key_hex: submitted_key })
      end
    end

    context 'when a non valid key is submitted' do
      let(:submitted_key) { 'npub1wqkvr9k8j23jyuqyym9fcnyxjpxyanujxsmyvpl7kyntcm0meh7qecu1rh' }

      it 'raises an ArgumentError' do
        expect{subject.convert}.to raise_error(ArgumentError, 'Invalid nip19 string.')
      end
    end

    context 'when a private key is submitted' do
      let(:submitted_key) { 'nsec13zhz499rt93n7pxm56ugu2jxh2q0ngmqzc6ut86rfz3vm78m4wess22iuy' }

      it 'it raises a PrivateKeyError' do
        expect{subject.convert}.to raise_error(KeyConverterService::PrivateKeyError, "Don't submit private keys. For security reasons we try to discard them when they are detected")
      end
    end
  end
end
