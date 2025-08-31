# app/models/api_key.rb
class ApiKey < ApplicationRecord
  belongs_to :organisation
  has_secure_token :token
end
