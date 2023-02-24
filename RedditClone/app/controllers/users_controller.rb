class UsersController < ApplicationController
    before_action :ensure_logged_in, only: [:destroy, :edit, :update, :index, :show]
    before_action :ensure_logged_out, only: [:new, :create]

    def index
        @users = User.all
        render :index
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            flash[:messages] = ["Successfully signed up!"]
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new
        render :new
    end

    def edit
        @user = User.find(params[:id])
        render :edit
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def update
        @user = User.find(params[:id])
        if @user
            @user.update(user_params)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = ["User does not exist!!"]
            render :edit
        end

    end

    def destroy
        @user = User.find(params[:id])
        if @user
            @user.destroy
            redirect_to new_user_url
        else
            flash[:errors] = ["User does not exist!!"]
            redirect_to users_url
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end



end
