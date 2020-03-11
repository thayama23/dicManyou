class Task < ApplicationRecord
  validates :name, presence: true 
  validates :detail, presence: true 

  enum progress: { "未着手": 0, "着手中": 1, "完了": 2 }
  # enum progress: %i[未着手 着手中 完了]

  enum priority: { "低": 0, "中": 1, "高": 2 }
  # enum priority: %i[低 中 高]
  
  # enum progress_search: { "未着手": 0, "着手中": 1, "完了": 2, "全経過": 3 }
  # enum progress: { untouched: 0, in_progress: 1, completed: 2 }
  # step_2の降順のソート
  # default_scope -> { order(created_at: :desc) }

  # def name_search(name)
  #   # return all if name.blank?
  #   if name 
  #     Task.where(['content LIKE ?', "%#{params[:name]}%"])
  #   else
  #     Task.all.order(created_at:desc)
  #   end
  # end

  # scope :search_task, -> (keyword) { search_name("%#{[:task][:name]}%").and(search_progress("%#{[:task][:progress]}%")) if keyword.present? }

  scope :search_name, -> (name) { where(name: name) if name.present? }

  # scope :search_name, -> (name) { where('name LIKE ?', "%#[:name]}%") if name.present? }

  scope :search_progress, -> (progress) { where(progress: progress) if progress.present? }


  
end

