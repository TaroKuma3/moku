class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    # @work_randoms = Work.where(pick_up: true).where(deleted: false).order(created_at: 'desc').limit(3)
    # @do_mokus = DoMoku.where(user_id: current_user.id).where(deleted: false) #カレンダーのために取得
  end

  def show
  end
end
