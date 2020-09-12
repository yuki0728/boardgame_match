class AddTimeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start_time, :datetime
    add_column :events, :ending_time, :datetime
  end
end
