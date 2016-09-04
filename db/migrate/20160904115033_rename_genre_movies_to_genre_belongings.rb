class RenameGenreMoviesToGenreBelongings < ActiveRecord::Migration[5.0]
  def change
    rename_table :genres_movies, :genre_belongings
  end
end
