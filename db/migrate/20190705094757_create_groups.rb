class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :types
      t.integer :workspace_id
      t.integer :owner
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
