class Project < ApplicationRecord
  has_many :snags, dependent: :destroy
end
