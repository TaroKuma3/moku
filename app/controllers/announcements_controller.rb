class AnnouncementsController < ApplicationController
  
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]
  before_action :ensure_admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @announcement = Announcement.all.order(created_at: 'asc')
    @user = current_user
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.user_id = current_user.id

    if @announcement.save
      flash[:notice] = "お知らせを登録しました！"
      redirect_to(announcements_path)
    else
      render action: :new
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
    @user = current_user
  end

  def update
    @announcement = Announcement.find(params[:id])
    @announcement.update(announcement_params)

    if @announcement.save
      flash[:notice] = "FAQを更新しました！"
      redirect_to(announcements_path)
    else
      render action: :edit
    end
  end


  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy
    redirect_to(announcements_path)
  end

  private
  def ensure_admin_user
    user = current_user

    if user.admin == false
      flash[:notice] = "権限がありません！"
      redirect_to(mypage_path)
    end
  end

  def announcement_params
    params.require(:announcement).permit(:id, :title, :body)
  end
end
