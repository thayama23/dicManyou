class UsersController < ApplicationController
    def index
        
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
        @user = User.find(params[:id])
    end

    def update
    end

    def destroy
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password,
            :password_confirmation)
    end

end
