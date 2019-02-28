class BookMarksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user

  def index
    @user = current_user
    @book_marks = BookMark.where(user_id: params[:user_id]).where(deleted: false)
  end

  def create
    @book_mark = BookMark.new(
      user_id: current_user.id,
      work_id: params[:work_id]
      )

      @book_mark.save!
      work = Work.find(@book_mark.work_id)
      if work.user_id == current_user.id
        redirect_to user_work_path(current_user.id, params[:work_id])
      else
        redirect_to ("/users/#{work.user_id}/works/#{work.id}/public")
      end
  end

  def destroy
    @book_mark = BookMark.find_by(
      user_id: current_user.id,
      work_id: params[:work_id]
      )

    @book_mark.destroy
    work = Work.find(@book_mark.work_id)
    if work.user_id == current_user.id
      redirect_to user_work_path(current_user.id, params[:work_id])
    else
      redirect_to ("/users/#{work.user_id}/works/#{work.id}/public")
    end
  end
end