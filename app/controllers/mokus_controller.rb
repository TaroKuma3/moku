class MokusController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only:[:index, :show, :new, :create, :edit, :update]
  skip_before_action :verify_authenticity_token, only:[:ajax_create]

  def index
    if params[:moku_type] # 絞り込みされたら
      @do_mokus = DoMoku.where(user_id: current_user.id).where(moku_type_id: params[:moku_type]).where(deleted: false).order(created_at: 'desc').paginate(page: params[:page], per_page: 10)
    else #絞り込みされなかったら
      @do_mokus = DoMoku.where(user_id: current_user.id).where(deleted: false).order(created_at: 'desc').paginate(page: params[:page], per_page: 10)
    end

    # moku_timeの合計時間表示
    @moku_time_sum = 0
    @do_mokus.each do |do_moku|
      @moku_time_sum += do_moku.moku_time
    end

  end

  def day_by_index
    @do_moku = DoMoku.find(params[:id])

    select_day = Date.parse(@do_moku.created_at.to_s)
    @same_day_mokus = DoMoku.where(user_id: current_user.id).where(created_at: select_day.all_day).where(deleted: false)
  end

  def show
    @user = current_user
    @do_moku = DoMoku.find(params[:id])
    @moku_type = MokuType.find(@do_moku.moku_type_id)
    @works = Work.where(do_moku_id: @do_moku.id).where(deleted: false).order(created_at: 'desc').paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = current_user
    @moku_types = MokuType.where(user_id: @user.id)
    public_users = User.where(public: true)
    @default_mjns = DoMoku.where(user_id: public_users.ids).where(deleted: false).order(created_at: 'desc').limit(5)
  end

  def ajax_create
    do_moku = DoMoku.new
    do_moku.user_id = params[:user_id]
    do_moku.moku_type_id = params[:moku_type_id]
    do_moku.started_at = DateTime.now
    do_moku.moku_time = 0

    if do_moku.save!
      render json: do_moku
    else
      render :new
    end
  end

  def finish
    do_moku = DoMoku.find params[:id]
    do_moku.finished_at = DateTime.now
    do_moku.moku_time = params[:moku_time]

    do_moku.save!
    flash[:notice] = "おつかれさまでした！"
    redirect_to("/mypage")
  end

  def edit
    @user = current_user
    @do_moku = DoMoku.find(params[:id])
  end

  def update
    user = current_user
    @do_moku = DoMoku.find(params[:id])
    @do_moku.memo = params[:do_moku][:memo]
    moku_type = MokuType.find(params[:do_moku][:moku_type])
    @do_moku.moku_type = moku_type

    if @do_moku.save!
      flash[:notice] = "更新しました！"
    else
      render action: :edit
    end

    redirect_to action: :show, user_id: user.id, id: @do_moku.id
  end

  def check_delete
    @do_moku = DoMoku.find(params[:moku_id])
    @works = Work.where(do_moku_id: @do_moku.id)
    @user = current_user
  end

  def delete
    do_moku = DoMoku.find(params[:moku_id])
    do_moku.deleted = true
    do_moku.save!

    works = Work.where(do_moku_id: do_moku.id)
    works.each do |work|
      work.deleted = true
      work.save!

      book_marks = BookMark.where(work_id: work.id)
      book_marks.each do |book_mark|
        book_mark.deleted = true
        book_mark.save!
      end
    end

    flash[:notice] = "mokuを削除しました！"
    redirect_to(user_mokus_path)
  end

  def justnow
    public_users = User.where(public: true)
    do_mokus = DoMoku.where(user_id: public_users.ids).where(deleted: false).order(created_at: 'desc').limit(5) # 最新を先に表示するから、desc
    render json: do_mokus, include:[:user, :moku_type], methods: [:format_created_at]#これでmokusがjson(≒JSのハッシュ)になる。さらになぜかuserモデルとmoku_typeモデルが拾える。
  end
end