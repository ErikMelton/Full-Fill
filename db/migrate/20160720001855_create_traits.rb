class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string :traitname
      t.string :trait_desc
      t.integer :facet_id
      t.integer :trait_spec_id

      t.timestamps null: false
    end
  end
end
