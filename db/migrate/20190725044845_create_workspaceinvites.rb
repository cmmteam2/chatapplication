class CreateWorkspaceinvites < ActiveRecord::Migration[5.2]
  def change
    create_table :workspaceinvites do |t|
      t.string :email
      t.boolean :confirm
      t.integer :workspace_id
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
