class CreateSnags < ActiveRecord::Migration[7.2]
  def change
    create_table :snags do |t|
      t.references :project, null: false, foreign_key: true
      t.string :location
      t.text :description
      t.string :created_by

      t.timestamps
    end
  end
end
