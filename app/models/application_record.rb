class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # enum progress: {"未着手": 0, "着手中": 1, "完了": 2}

end
 

