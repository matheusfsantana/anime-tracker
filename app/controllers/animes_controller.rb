class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def create
  end

  def new
    @anime = Anime.new
  end

  def show
    @anime = Anime.find(params[:id])
  end
end
