class AnimesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_anime, only: [ :show, :edit, :update ]
  before_action :redirect_unless_admin, only: [ :edit, :update, :create, :new ]
  def index
    @animes = Anime.all
  end

  def create
    @anime = Anime.new(anime_params)

    if @anime.save
      redirect_to @anime, notice: "Anime salvo com sucesso"
    else
      flash.now[:alert] = "Erro ao tentar salvar anime"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @anime.update(anime_params)
      redirect_to @anime
    else
      flash.now[:alert] = "Erro ao tentar alterar o anime"
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end
  def new
    @anime = Anime.new
  end

  def show
  end

  private

  def anime_params
    params.require(:anime).permit(:title, :sinopse, :poster, :status, :quantity_episodes)
  end

  def set_anime
    @anime = Anime.find(params[:id])
  end
end
