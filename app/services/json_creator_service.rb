class JsonCreatorService
  def content(name:)
    if name.present?
      user = User.where('lower(username) = ?', name.downcase).first
      if user
        { names: { user.username => user.public_key_hex } }.to_json
      else
        { names: {} }.to_json
      end
    else
      names = {}

      User.find_each { |user| names[user.username] = user.public_key_hex }

      { names:  names }.to_json
    end
  end
end
