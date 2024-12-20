class ProfileController < ApplicationController
  before_action :set_profile, only: :show
  def show ; end

  private
  def set_profile
    @user_profile = User.find_by(nickname: params[:nickname])
  end
end
