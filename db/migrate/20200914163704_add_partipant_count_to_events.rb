class AddPartipantCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :participant_limit, :integer
  end
end
