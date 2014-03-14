class RemoveDateToFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :date_to
  end

  def down
    add_column :tasks, :date_to, :datetime
  end
end