class UsersController < ApplicationController


    def index

        render :index
    end

    def create
        @user = User.new(user_params)

        if @user.save
            #log user in
            flash[:messages] = ["Successfully signed up!"]
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        render :new
    end

    def edit
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



end
