class AddPartipantToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :participant_id, :integer
  end
end
