class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id]) if Movie.exists?(params[:id])

    render :show
  end
end
