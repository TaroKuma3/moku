class ApplicationController < ActionController::Base
  # devise signup時nameを登録
  before_action :configure_permitted_parameters, if: :devise_controller?

  # devise　login後の表示先指定
  def after_sign_in_path_for(resource)
    "/mypage"
  end

  private
  # devise for:before_action
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def ensure_current_user
    @user = User.find(params[:user_id])

    unless @user.id == current_user.id
      flash[:notice] = "権限がありません！！"
      redirect_to("/mypage")
    end
  end

end
