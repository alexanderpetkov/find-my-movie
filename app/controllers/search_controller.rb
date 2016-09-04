class SearchController < ApplicationController
  before_action :sanitize, only: :movies

  def movies
    @movies = Movie.search(@query).records

    respond_to do |format|
      format.js
    end
  end

  private

  def sanitize
    @query = params.fetch(:q, '').gsub(/[^0-9a-z ]/i, '')
  end
end
