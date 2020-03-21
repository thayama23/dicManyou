class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_login

    def index
      @users = User.all
      unless current_user.admin?
        redirect_to user_path(current_user), notice: '管理者権限ページへアクセスは出来ません!'
      end
    end

    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to user_path(@user.id)
        else
          render :new
        end
    end

    def new
        @user = User.new
    end

    def edit
    end

    def show
      @tasks = @user.tasks
    
        # unless @user == current_user ##こう(true)でなければ、
        #     redirect_to tasks_path, notice: '他の人のページへアクセスは出来ません!'
        # end
    end

    def update
        if @user.update(user_params)
          redirect_to user_path(@user.id), notice: "ユーザー詳細を編集しました！"
        else
          render :edit
        end
    end

    def destroy
      # @user.destroy
      # redirect_to admin_users_path, notice: 'ユーザーは削除されました。'
      if @user.destroy
        redirect_to admin_users_path, notice: 'ユーザーは削除されました。'
      else
        redirect_to admin_users_path, notice: 'ユーザーは削除出来ませんでした'
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password,
            :password_confirmation, :admin)
    end
end