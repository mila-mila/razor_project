class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :content
      t.integer :user_id
      t.datetime :date_from
      t.datetime :date_to
      t.datetime :date_finished

      t.timestamps
    end
    add_index :tasks, [:user_id, :name]
  end
end
