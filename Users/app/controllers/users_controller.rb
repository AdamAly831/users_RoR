class UsersController < ApplicationController
   before_action :require_login, except: [:new, :create]
    before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def new
  end
#================
  def edit
    @user = User.find(params[:id])
  end
  #================
 def show
    @user = User.find(params[:id])
    @secrets = @user.secrets
    @secrets_liked = @user.secrets_liked.group(:id).order(:id)
  end
  #================
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

#================

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User updated"
      redirect_to @user #this should make the user go back to their user name with the same ID 
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back #reload the same page untill they update the user name 
    end
  end
#================
  def destroy
    user = User.find(params[:id])
    user.destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"    
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
  