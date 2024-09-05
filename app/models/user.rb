class User < ApplicationRecord
  validates_presence_of :public_key
  validates_uniqueness_of :public_key, :public_key_hex
  validates :username,
            format: {
              with: /^[A-Za-z0-9\-_\.]{2,30}$/,
              multiline: true,
              presence: true,
              uniqueness: true,
              message: 'Only a-z0-9-_. are allowed in usernames. 2-30 character length limitation.'
            }
end
