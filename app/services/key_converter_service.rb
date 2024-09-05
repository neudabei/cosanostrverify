class KeyConverterService
  PrivateKeyError = Class.new(StandardError)

  def initialize(submitted_public_key)
    @submitted_public_key = submitted_public_key
  end

  def convert
    verified_public_key     = ''
    verified_public_key_hex = ''

    if submitted_public_key.starts_with?('nsec')
      raise PrivateKeyError, "Don't submit private keys. For security reasons we try to discard them when they are detected"
    elsif submitted_public_key.starts_with?('npub')
      verified_public_key = submitted_public_key
      verified_public_key_hex = Bech32::Nostr::NIP19.decode(submitted_public_key).data
    else
      verified_public_key = Bech32::Nostr::BareEntity.new('npub', submitted_public_key).encode
      verified_public_key_hex = submitted_public_key
    end

    { public_key: verified_public_key, public_key_hex: verified_public_key_hex }
  end

  private

  attr_reader :submitted_public_key
end
