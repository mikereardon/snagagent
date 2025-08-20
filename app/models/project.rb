class Project < ApplicationRecord
  has_many :snags, dependent: :destroy

  belongs_to :organisation
end
