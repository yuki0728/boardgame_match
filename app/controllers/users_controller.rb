class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def def update
    @user = User.find(params[:id])
    if @event.update(events_params)
      redirect_to @user, success: "プロフィールを更新しました"
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:username)
  end
end
