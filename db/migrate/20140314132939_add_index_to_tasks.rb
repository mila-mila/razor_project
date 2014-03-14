class AddIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :date_from
  end
end
