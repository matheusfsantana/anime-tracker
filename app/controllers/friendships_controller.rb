class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:user_id])
    @friendship = Friendship.new(user: current_user, friend: friend)
    if @friendship.save
      redirect_to profile_path(nickname: friend.nickname), notice: "Pedido de amizade enviado"
    else
      redirect_to profile_path(nickname: friend.nickname), alert: "Erro ao tentar enviar um pedido de amizade enviado"
    end
  end
  def index
    @pending = params[:pending]
    @friendship_list = current_user.accepted_friendships
    @friendship_list = current_user.pending_friendships if @pending
  end

  def accept
    @friendship = Friendship.find_by(id: params[:id], friend: current_user)
    @friendship_list = current_user.pending_friendships

    unless @friendship
      flash.now[:alert] = "Solicitação de amizade não encontrada"
      return render "index", status: :not_found
    end

    if @friendship.update(status: :accepted)
      redirect_to friendships_path
    else
      flash.now[:alert] = "Erro ao tentar aceitar pedido de amizade"
      render "index", status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    unless @friendship.user == current_user || @friendship.friend == current_user
      @friendship_list = current_user.accepted_friendships
      flash.now[:alert] = "Não foi possível remover a amizade"
      return render "index", status: :not_found
    end
    if @friendship.delete
      redirect_to friendships_path, notice: "Amizade removida com sucesso"
    else
      redirect_to friendships_path, alert: "Não foi possível remover a amizade"
    end
  end
end
