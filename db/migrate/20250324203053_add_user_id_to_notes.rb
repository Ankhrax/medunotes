class AddUserIdToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :user_id, :integer
  end
end
