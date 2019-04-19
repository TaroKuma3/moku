class ApplicationController < ActionController::Base
  # devise signup時nameを登録
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ↓セキュリティトークンが自動で含まれる（CSRF防止）
  #protect_from_forgery with: :exception

  # devise　login後の表示先指定
  def after_sign_in_path_for(resource)
    mypage_path
  end

  private
  # deviseストロングパラメータ（name、accepted：利用規約チェックの追加）
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :accepted)}
  end

  def ensure_current_user
    @user = User.find(params[:user_id])

    unless @user.id == current_user.id
      flash[:notice] = "権限がありません！！"
      redirect_to("/mypage")
    end
  end

end
