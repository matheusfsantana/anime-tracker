class ProfilesController < ApplicationController
  layout "dashboard"
  before_action :set_profile, only: :show
  before_action :authenticate_user!

  def show
    redirect_to profile_path(current_user.nickname), alert: "O perfil que tentou acessar não existe!" if @user_profile.blank?
  end

  def edit
    @user_profile = current_user.profile
  end

  def update
    @user_profile = current_user.profile
    return redirect_to profile_path(@user_profile.user.nickname), notice: "Perfil foi atualizado com sucesso!" if @user_profile.update(profile_params)
    flash.now[:alert] = "Erro ao tentar alterar o perfil"
    render :edit, status: :unprocessable_entity
  end

  private
  def set_profile
    @user_profile = User.find_by(nickname: params[:nickname])
  end

  def profile_params
    params.require(:profile).permit(:about, :privacy)
  end
end
