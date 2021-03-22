class AddColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :participations_count, :integer
  end
end
