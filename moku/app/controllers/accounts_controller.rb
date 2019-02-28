class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.name = params[:user][:name]
    @user.items = params[:user][:items]
    @user.introduce = params[:user][:introduce]
    @user.public = params[:user][:public]

    if @user.save
      flash[:notice] = "更新しました！"
      redirect_to ("/mypage")
    else
      render :edit
    end
  end

  def check_delete
    @user = current_user
  end

  def delete
    user = current_user
    user.deleted = true
    user.save!

    mokus = Moku.where(user_id: current_user.id)
    mokus.each do |moku|
      moku.deleted = true
      moku.save!
    end

    moku_types = MokuType.where(user_id: current_user.id)
    moku_types.each do |moku_type|
      moku_type.deleted = true
      moku_type.save!
    end

    works = Work.where(user_id: current_user.id)
    works.each do |work|
      work.deleted = true
      work.save!

      book_marks = BookMark.where(work_id: work.id)
      book_marks.each do |book_mark|
        book_mark.deleted = true
        book_mark.save!
      end
    end

  flash[:notice] = "ご利用ありがとうございました！またいつでも戻ってきてください！"
  reset_session
  redirect_to ("/")
  end
end
