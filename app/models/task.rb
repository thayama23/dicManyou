class Task < ApplicationRecord
  belongs_to :user
  # validates :user_id, presence: true 

  enum progress: { "未着手": 0, "着手中": 1, "完了": 2 }
  # enum progress: %i[未着手 着手中 完了]
  enum priority: { "低": 0, "中": 1, "高": 2 }
  # enum priority: %i[低 中 高]

  validates :name, presence: true 
  validates :detail, presence: true 

  # step_2の降順のソート
  # default_scope -> { order(created_at: :desc) }



  # scope :search_task, -> (keyword) { search_name("%#{[:task][:name]}%").and(search_progress("%#{[:task][:progress]}%")) if keyword.present? }

  # scope :search_name, -> (name) { where(name: name) if name.present? }
  # scope :search_name, -> (name) { where('name LIKE ?', "%#{[:name]}%") if name.present? }
  scope :search_name, -> (name) { where("name LIKE ?", "%#{(name)}%") if name.present? }
  scope :search_progress, -> (progress) { where(progress: progress) if progress.present? }


  
end

