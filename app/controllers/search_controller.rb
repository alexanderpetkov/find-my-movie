class SearchController < ApplicationController
  before_action :sanitize, only: [:movies, :movie_suggestions]

  def movies
    @movies = Movie.search(@query).records

    respond_to do |format|
      format.js
    end
  end

  def movie_suggestions
    @suggestions = Movie.suggest(@query)['movies'].first['options']

    respond_to do |format|
      format.js
    end
  end

  private

  def sanitize
    @query = params.require(:q).gsub(/[^0-9a-z ]/i, '')
  end
end
