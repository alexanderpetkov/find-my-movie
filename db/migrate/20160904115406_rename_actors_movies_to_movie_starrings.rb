class RenameActorsMoviesToMovieStarrings < ActiveRecord::Migration[5.0]
  def change
    rename_table :actors_movies, :movie_starrings
  end
end
