class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper


    # def forbid_login_user
    #     redirect_to tasks_path, notice: 'すでにログインしています' if current_user
    # end


end
