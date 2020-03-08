class Task < ApplicationRecord
  validates :name, presence: true 
  validates :detail, presence: true 

  enum progress: { "未着手": 0, "着手中": 1, "完了": 2 }
  # enum progress: { untouched: 0, in_progress: 1, completed: 2 }
  # step_2の降順のソート
  # default_scope -> { order(created_at: :desc) }
end

