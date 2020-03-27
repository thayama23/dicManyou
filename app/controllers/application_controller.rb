class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    # if !Rails.env.development?
    #     rescue_from Exception,                        with: :render_500
    #     rescue_from ActiveRecord::RecordNotFound,     with: :render_404
    #     rescue_from ActionController::RoutingError,   with: :render_404
    #   end
    # def forbid_login_user
    #     redirect_to tasks_path, notice: 'すでにログインしています' if current_user
    # end


end
