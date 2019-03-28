class TopController < ApplicationController
  before_action :forbid_login_user
  
  def index
  end

  def about
  end

  def bye
  end

  private
    def forbid_login_user
      if current_user
        flash[:notice] = "すでにログイン済みです"
        redirect_to ("/mypage")
      end
    end
end
