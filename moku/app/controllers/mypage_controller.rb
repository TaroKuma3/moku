class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    public_users = User.where(public: true)
    @work_pickups = Work.where(user_id: public_users.ids).where(pickup_public: true).where(deleted: false).order(created_at: 'desc').limit(3)
    @do_mokus = DoMoku.where(user_id: current_user.id).where(deleted: false) #カレンダーのために取得
  end

  #↓current_userにしてはいけない。pick upで成果物の作者を見にくる場合もアクセスされるから。
  def show
    @user = User.find(params[:user_id])
  end
end
