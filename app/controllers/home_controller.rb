class HomeController < ApplicationController
  before_action :redirect_if_authenticated
  def index ;  end

  private

  def redirect_if_authenticated
    if user_signed_in?
      redirect_to profile_path current_user.nickname
    end
  end
end
