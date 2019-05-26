class MokuTypeController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user

  def index
    @user = current_user
    @moku_type = MokuType.new
    @moku_types = MokuType.where(user_id: @user.id).where(deleted: false)
  end

  def show
    @moku_type = MokuType.find(params[:id])
    @do_mokus = DoMoku.where(moku_type_id: @moku_type.id).order(created_at: 'desc')
  end

  def new
    @user = current_user
    @moku_type = MokuType.new
    @moku_types = MokuType.where(user_id: current_user.id)
  end

  def create
    @user = current_user
    @moku_types = MokuType.where(user_id: current_user.id)

    @moku_type = MokuType.new(
      name: params[:name],
      user_id: params[:user_id],
    )
    if @moku_type.save
      flash[:notice] = "新しいmokuタグを登しました！"
      redirect_to(user_moku_type_index_path(@user))
    else
      render action: :new
    end
  end

  def edit
    @moku_types = MokuType.where(user_id: current_user.id)
    @moku_type = MokuType.find(params[:id])
  end

 def update
    @moku_types = MokuType.where(user_id: current_user.id)
    @moku_type = MokuType.find(params[:id])
    @moku_type.name = params[:moku_type][:name]
    @moku_type.user_id = current_user.id

    if @moku_type.save
      flash[:notice] = "更新しました！"
      redirect_to(user_moku_type_index_path(@user))
    else
      render :edit
    end
  end

  def check_delete
    @moku_type = MokuType.find(params[:moku_type_id])
    @do_mokus = DoMoku.where(moku_type_id: @moku_type.id)
  end

  def delete
    moku_type = MokuType.find(params[:moku_type_id])
    default_moku_type = MokuType.find_by(
      user_id: moku_type.user_id,
      name: Constants::DEFAULT_MOKU_TYPE_NAME)
    moku_type.deleted = true
    moku_type.save!

    do_mokus = DoMoku.where(moku_type_id: moku_type.id)
    do_mokus.each do |do_moku|
      do_moku.moku_type_id = default_moku_type.id
      do_moku.save!
    end

    flash[:notice] = "mokuタグを削除しました！"
    redirect_to(user_moku_type_index_path(moku_type.user_id))
  end

end
