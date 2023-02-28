class CreateJobsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.integer :project_id
    end
  end
end
