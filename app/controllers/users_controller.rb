class UsersController < ApplicationController
    before_action :set_users, only: [:show, :edit, :update]


    def show 
         @articles = @user.articles.paginate(page: params[:page], per_page:2)
         
    end
    
    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 2)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the alpha Blog #{@user.username}, you've successfully signed-up"            
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your account info was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    private 

    def set_users
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
