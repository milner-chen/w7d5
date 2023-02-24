class SubsController < ApplicationController
    before_action :ensure_logged_in, only: [:destroy, :edit, :update, :index, :show]
    before_action :ensure_logged_out, only: [:new, :create]
    before_action :ensure_moderator, only: [:edit, :update]

    def index
        @subs = Sub.all
        render :index
    end

    def create
        @sub = Sub.new(sub_params)

        if @sub.save
            flash[:messages] = ["Successfully created sub!"]
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def new
        @sub = Sub.new
        render :new
    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub
            @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = ["Sub does not exist!!"]
            render :edit
        end

    end

    def destroy
        @sub = Sub.find(params[:id])
        if @sub
            @sub.destroy
            redirect_to subs_url
        else
            flash[:errors] = ["Sub does not exist!!"]
            redirect_to subs_url
        end
    end

    def ensure_moderator
        redirect_to subs_url unless self.moderator_id == current_user.id
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end
end
