class AnimesController < ApplicationController
  before_action :set_anime, only: [ :show, :edit, :update ]
  def index
    @animes = Anime.all
  end

  def create
    @anime = Anime.new(anime_params)

    if @anime.save
      redirect_to @anime, notice: "Anime salvo com sucesso"
    else
      flash.now[:alert] = "Erro ao tentar salvar anime"
      render "new"
    end
  end

  def update
    if @anime.update(anime_params)

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
