class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string 'title'
      t.integer 'year'
      t.integer 'length'
      t.integer 'popularity'
      t.boolean 'award_winning'

      t.timestamps
    end
  end
end
