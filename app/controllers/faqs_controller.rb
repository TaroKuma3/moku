class FaqsController < ApplicationController

  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]
  before_action :ensure_admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    if  params[:tag]
      @faqs = Faq.tagged_with(params[:tag]).order(created_at: 'asc').paginate(page: params[:page], per_page: 5)
    else
      # @faqs = Faq.all
      @faqs = Faq.order(created_at: 'asc').paginate(page: params[:page], per_page: 5)
    end
  end

  def show
    @faq = Faq.find(params[:id])
  end

  def new
    @faq = Faq.new
    @user = current_user
  end

  def create
    @faq = Faq.new(faq_params)
      @faq.user_id = current_user.id

    if @faq.save
      flash[:notice] = "FAQを登録しました！"
      redirect_to(faqs_path)
    else
      render(faqs_new_path)
    end
  end

  def edit
    @faq = Faq.find_by(id: params[:id])
    @user = current_user
  end

  def update
    @faq = Faq.find(params[:id])
    @faq.update(faq_params)

    if @faq.save
      flash[:notice] = "FAQを更新しました！"
      redirect_to("/faqs/#{@faq.id}")
    else
      render action: :edit
    end
  end


  def destroy
    @faq = Faq.find_by(id: params[:id])
    @faq.destroy
    redirect_to(faqs_path)
  end

  private
  def ensure_admin_user
    user = current_user

    if user.admin == false
      flash[:notice] = "権限がありません！"
      redirect_to(mypage_path)
    end
  end

  def faq_params
    params.require(:faq).permit(:id, :questions, :answer, :category_list)
  end
end
