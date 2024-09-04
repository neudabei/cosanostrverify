class JsonCreatorService
  def content
    names = {}

    User.find_each { |user| names[user.username] = user.public_key_hex }

    { names:  names }.to_json
  end
end
