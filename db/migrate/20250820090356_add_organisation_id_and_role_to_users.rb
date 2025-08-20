class AddOrganisationIdAndRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :organisation, null: false, foreign_key: true
    add_column :users, :role, :string
  end
end
