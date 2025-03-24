class AddLastViewedAtToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :last_viewed_at, :datetime
  end
end
