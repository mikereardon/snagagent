class MakeOrganisationIdNotNullOnSnags < ActiveRecord::Migration[7.2]
  def change
    change_column_null :snags, :organisation_id, false
  end
end
