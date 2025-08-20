class AddOrganisationIdToSnags < ActiveRecord::Migration[7.2]
  def change
    add_reference :snags, :organisation, foreign_key: true
  end
end
