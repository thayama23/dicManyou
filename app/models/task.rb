class Task < ApplicationRecord
  validates :name, presence: true 
  validates :detail, presence: true 
  
  # step_2の降順のソート
  default_scope -> { order(created_at: :desc) }
end
