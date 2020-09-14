class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.string :user_id
      t.string :event_id

      t.timestamps
    end
  end
end
