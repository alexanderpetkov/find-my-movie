class CreateActorsMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :actors_movies, id: false do |t|
      t.belongs_to :actor, index: true
      t.belongs_to :movie, index: true
    end
  end
end
