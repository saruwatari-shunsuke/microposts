class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @microposts = @user.microposts.page(params[:page]).per(5).order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = @user.name + " 's  followings"
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = @user.name + " 's  followers"
    @users = @user.follower_users
    render 'show_follow'
  end
  
  private
    
  def user_params
    params.require(:user).permit(:name, :email, :location, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
  end
end