class AddTimestamptsToGenres < ActiveRecord::Migration[5.0]
  def change
    add_timestamps(:genres)
  end
end
