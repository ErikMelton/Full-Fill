class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name_first
      t.string :name_middle
      t.string :name_last
      t.string :name_nick
      t.string :name_prefix
      t.string :name_suffix
      t.date :birth_date

      t.timestamps null: false
    end
  end
end
