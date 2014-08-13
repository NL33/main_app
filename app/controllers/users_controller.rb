class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Main App!"
      redirect_to @user
    else
      render 'new'
    end
  end

   def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirsect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

       # Before filters

    def signed_in_user #means you must sign in to edit
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

     def correct_user #means you must be the user to edit the user's info
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
