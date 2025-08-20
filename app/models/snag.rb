class Snag < ApplicationRecord
  belongs_to :project

  belongs_to :organisation
end
