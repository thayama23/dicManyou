class AddProgressToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :progress, :integer, null: false, default: 0
  end
end

