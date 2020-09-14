class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン時の処理
  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインに成功しました"
    root_path
  end

  # ログアウト時の処理
  def after_sign_out_path_for(resource)
    flash[:alert] = "ログアウトしました"
  end

  private

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected

  # strong_parametersを設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
