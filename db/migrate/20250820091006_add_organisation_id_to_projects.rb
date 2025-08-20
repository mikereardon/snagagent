class AddOrganisationIdToProjects < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects, :organisation, foreign_key: true
  end
end
