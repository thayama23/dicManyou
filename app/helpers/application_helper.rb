module ApplicationHelper
    def forbid_login_user
        redirect_to tasks_path, notice: 'すでにログインしています' if current_user
      end
end
