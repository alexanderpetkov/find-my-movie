class AddTimestamptsToDirectors < ActiveRecord::Migration[5.0]
  def change
    add_timestamps(:directors)
  end
end
