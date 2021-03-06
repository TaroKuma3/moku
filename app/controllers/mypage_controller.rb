class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    # for announcements
    @works_announcements = Work.where(user_id: current_user.id).where(deleted: false).order(created_at: 'desc').limit(3)
    @mokus_announcements = DoMoku.where(user_id: current_user.id).where(deleted: false).order(created_at: 'desc').limit(3)

    # for pick UP
    public_users = User.where(public: true)
    only_public_targets = Work.where(user_id: public_users.ids).where(pickup_public: true).where(deleted: false)
    pickup_target_ids = only_public_targets.pluck(:id).sample(5)
    @work_pickups = Work.find(pickup_target_ids)

    #for calender
    @do_mokus = DoMoku.where(user_id: current_user.id).where(deleted: false)

    # mjn初回読み込み前のためのデフォルトデータ
    @default_mjns = DoMoku.where(user_id: public_users.ids).where(deleted: false).order(created_at: 'desc').limit(5)

    # announcement
    @announcement = Announcement.all.order(created_at: 'desc').limit(5)
  end

  #↓current_userにしてはいけない。pick upで成果物の作者を見にくる場合もアクセスされるから。
  def show
    @user = User.find(params[:user_id])
  end
end
