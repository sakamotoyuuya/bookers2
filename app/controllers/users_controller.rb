class UsersController < ApplicationController
 def index
  @user = User.find(current_user.id)
  @users = User.all
  @book = Book.new
 end

 def create
  @user = User.new(user_params)
  if @user.save
   redirect_to user_path(@user.id)
  else
   render root_path
  end
 end

 def show
  @user = User.find(params[:id])
  @book = Book.new
 end

 def edit
  @user = User.find(params[:id])
  unless @user.id == current_user.id
   redirect_to user_path(current_user)
  end
 end

 def update
  @user = current_user
  if @user.update(user_params)
   flash[:notice] = "You have updated user successfully."
   redirect_to user_path(@user)
  else
   render :edit
  end
 end

 private

 def user_params
  params.require(:user).permit(:profile_image, :name, :introduction)
 end
end
