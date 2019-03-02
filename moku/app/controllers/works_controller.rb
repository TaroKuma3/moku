class WorkController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_current_user, only:[:index, :show, :edit, :update, :new, :create]

  def index
    @user = current_user
    @works = Work.where(user_id: params[:user_id]).where(deleted: false)
  end

  def show
    @work = Work.find(params[:id])
    @user = current_user #ここでひろうuser_idは自ページ分なのでcurrent_user
    @moku = Moku.find(@work.moku_id)
    @bm_count = BookMark.where(work_id: @work.id).count
  end

  def for_public
    @work = Work.find(params[:work_id])
    @user = User.find(params[:user_id]) #ここでひろうuser_idはpick upで見つけた他者のページにいくからURLに含まれるuser_id
    @moku = Moku.find(@work.moku_id)
    @bm_count = BookMark.where(work_id: @work.id).count
  end

  def new
    @user = current_user
    @moku = Moku.find(params[:id])
    @moku_type = MokuType.find(@moku.moku_type.id)
    @work = Work.new

    @work.comment_public = Constants::PRIVATE
    @work.pick_up = Constants::PRIVATE
  end

  def create
    @user = current_user
    @moku = Moku.find(params[:moku_id])
    @moku_type = MokuType.find(@moku.moku_type.id)

    @work = Work.new(work_params)
    @work.moku = Moku.find(params[:moku_id])
    @work.user = current_user

    if @work.save
      flash[:notice] = "登録しました！"
      redirect_to(user_work_index_path(@user))
    else
      render "new"
    end
  end

  def edit
    @work = Work.find(params[:id])
    @user = current_user
  end

  def update
    @user = current_user
    @work = Work.find(params[:id])
    @work.update(work_params)

    if @work.save
      flash[:notice] = "更新しました！"
      redirect_to(user_work_path(@user,@work))
    else
      render :edit
    end
  end

  def delete_image
    work = Work.find(params[:id])
    image = work.images.find params[:image_id]
    image.purge

    redirect_to("/users/#{current_user.id}/work/#{work.id}")

  end

  def check_delete
    @work = Work.find(params[:work_id])
  end
  def delete
    work = Work.find(params[:work_id])
    work.deleted = true
    work.save!

    book_marks = BookMark.where(work_id: work.id)
    book_marks.each do |book_mark|
      book_mark.deleted = true
      book_mark.save!
    end

    flash[:notice] = "成果物を削除しました☁︎"
    redirect_to(user_work_index_path(current_user.id))
  end


  private

  def work_params
    params.require(:work).permit(:comment, :title, :images, :user_id, :moku_id, :comment_public, :pick_up)
  end
end
