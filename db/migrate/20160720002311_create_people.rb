class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :client_id
      t.string :name_first
      t.string :name_middle
      t.string :name_last
      t.string :name_nick
      t.string :name_prefix
      t.string :name_suffix
      t.string :birth_date
      t.integer :physical_score
      t.integer :social_score
      t.integer :abstract_score
      t.integer :creative_score
      t.integer :expressive_score

      t.timestamps null: false
    end
  end
end
