class AddTimestamptsToActors < ActiveRecord::Migration[5.0]
  def change
    add_timestamps(:actors)
  end
end
