class ConnectedApplication < ApplicationRecord
  belongs_to :identity

  # Encryption
  attr_encrypted :refresh_token, :access_token

  # Enumeration
  enum provider: { github: 'github' }, _prefix: true
end