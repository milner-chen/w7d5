class SessionsController < ApplicationController
    before_action :ensure_logged_in, only: [:destroy]
    before_action :ensure_logged_out, only: [:new, :create]

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        
        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            @user = User.new
            flash.now[:errors] = ["Invalid Credentials!"]
            render :new
        end
        
    end

    def new
        @user = User.new
        render :new
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
