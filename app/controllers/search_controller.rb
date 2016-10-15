class SearchController < ApplicationController
  before_action :parse_params, only: [:movies, :movie_suggestions]

  MOVIE_COUNT = 10

  def movies
    @movies = Movie.search(@query, size: MOVIE_COUNT, from: @offset).records

    @more_left = @movies.size >= MOVIE_COUNT
    @loading_more = @offset.positive?

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

  def parse_params
    @query  = params.require(:q).gsub(/[^0-9a-z ]/i, '')
    @offset = params.fetch(:offset, 0).to_i
  end
end
