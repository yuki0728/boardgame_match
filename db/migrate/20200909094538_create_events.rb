class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :text
      t.integer :user_id
      t.string :place

      t.timestamps
    end
  end
end
