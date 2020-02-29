class RenameColumns < ActiveRecord::Migration[5.2]
  def change
  rename_column :tasks, :task_name, :name
  rename_column :tasks, :task_detail, :detail
  end
end
