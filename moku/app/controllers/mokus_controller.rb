class MokusController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only:[:index, :show, :new, :create, :edit, :update]
  skip_before_action :verify_authenticity_token, only:[:ajax_create]

  def index
    # 絞り込み用
    if params[:moku_type]
      @user = current_user
      @mokus = Moku.where(user_id: current_user.id).where(moku_type_id: params[:moku_type]).where(deleted: false).order(created_at: 'desc')
    else
      @user = current_user
      @mokus = Moku.where(user_id: @user.id).where(deleted: false).order(created_at: 'desc')
    end
  end

  def show
    @user = current_user
    @moku = Moku.find(params[:id])
    @moku_type = MokuType.find(@moku.moku_type_id)
    @works = Work.where(moku_id: @moku.id)
  end

  def new
    @user = current_user
    @moku_types = MokuType.where(user_id: @user.id)
  end

  def ajax_create
    moku = Moku.new
    moku.user_id = params[:user_id]
    moku.moku_type_id = params[:moku_type_id]
    moku.mjn_public = params[:mjn_public]
    moku.started_at = DateTime.now

    if moku.save!
      render json: moku
    else
      render :new
    end
  end

  def finish
    moku = Moku.find params[:id]
    moku.finished_at = DateTime.now
    moku.moku_time = params[:moku_time]

    moku.save!
    flash[:notice] = "おつかれさまでした！"
    redirect_to("/mypage")
  end

  def edit
    @user = current_user
    @moku = Moku.find(params[:id])
  end

  def update
    user = current_user
    @moku = Moku.find(params[:id])
    @moku.content = params[:moku][:content]
    moku_type = MokuType.find(params[:moku][:moku_type])
    @moku.moku_type = moku_type

    if @moku.save!
      flash[:notice] = "更新しました！"
    else
      render action: :edit
    end

    redirect_to action: :show, user_id: user.id, id: @moku.id
  end

  def check_delete
    @moku = Moku.find(params[:moku_id])
    @works = Work.where(moku_id: @moku.id)
  end

  def delete
    moku = Moku.find(params[:moku_id])
    moku.deleted = true
    moku.save!

    works = Work.where(moku_id: moku.id)
    works.each do |work|
      work.deleted = true
      work.save!

      book_marks = BookMark.where(work_id: work.id)
      book_marks.each do |book_mark|
        book_mark.deleted = true
        book_mark.save!
      end
    end

    flash[:notice] = "MOKUを削除しました☁︎"
    redirect_to(user_mokus_path)
  end

  def justnow
    mokus = Moku.where(mjn_public: true).where(deleted: false).order(created_at: 'desc').limit(5) # 最新を先に表示するから、desc
    render json: mokus, include:[:user, :moku_type], methods: [:format_created_at]#これでmokusがjson(≒JSのハッシュ)になる。さらになぜかuserモデルとmoku_typeモデルが拾える。
  end
end