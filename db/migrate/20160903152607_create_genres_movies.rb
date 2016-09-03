class CreateGenresMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :genres_movies do |t|
      t.belongs_to :genre, index: true
      t.belongs_to :movie, index: true
    end
  end
end
