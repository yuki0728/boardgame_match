class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:username)
  end
end
