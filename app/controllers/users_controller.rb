class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @user = current_user
    @books = @user.books
    @users = User.all
  end

  def edit
  @user = User.find(params[:id])
  unless @user.id == current_user.id
    redirect_to user_path(current_user)
  end

  end


  def update
   @user = User.find(params[:id])
   if @user.update(user_params)

    redirect_to user_path(@user), notice: "You have updated user successfully."
   else
    render :edit
   end
  end

  private

  def user_params
     params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
