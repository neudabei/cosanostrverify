class User < ApplicationRecord
  validates_presence_of :username, :public_key
  validates_uniqueness_of :username, :public_key
end
