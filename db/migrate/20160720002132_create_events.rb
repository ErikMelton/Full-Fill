class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :person_id
      t.integer :activity_hours
      t.integer :activity_id
      t.string :activity_note
      t.string :activity_place
      t.string :activity_when # Years old
      t.timestamps null: false
    end
  end
end
