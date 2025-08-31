class Snag < ApplicationRecord
  belongs_to :organisation
  belongs_to :project
  validate :project_same_org
  private
  def project_same_org
    return if project&.organisation_id == organisation_id
    errors.add(:project_id, "must belong to the same organisation")
  end
end
