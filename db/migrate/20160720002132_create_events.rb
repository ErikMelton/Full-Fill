class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :person_id
      t.integer :activity_hours
      t.string :activity_note
      t.string :activity_place
      t.string :activity_when

      t.timestamps null: false
    end
  end
end
