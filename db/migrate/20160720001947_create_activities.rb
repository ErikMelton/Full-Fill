class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activityname
      t.string :activity_desc
      t.integer :trait_id
      t.string :activity_note

      t.timestamps null: false
    end
  end
end
