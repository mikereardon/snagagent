class CreateApiKeys < ActiveRecord::Migration[7.2]
  def change
    create_table :api_keys do |t|
      t.references :organisation, null: false, foreign_key: true
      t.string :token
      t.string :name

      t.timestamps
    end
    add_index :api_keys, :token
  end
end
