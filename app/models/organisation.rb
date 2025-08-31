class Organisation < ApplicationRecord
  has_many :users
  has_many :projects
  has_many :snags
  has_many :api_keys
end
