class CreateProjectsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.integer :project_owner_id, null: false
      t.string :description, null: false
      t.integer :status, null: false, default: 0
      t.datetime :due
      t.timestamps
    end
    add_foreign_key :projects, :users, column: :project_owner_id
  end
end
