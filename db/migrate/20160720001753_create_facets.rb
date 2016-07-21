class CreateFacets < ActiveRecord::Migration
  def change
    create_table :facets do |t|
      t.string :facettype
      t.string :facet_long
      t.string :facet_desc

      t.timestamps null: false
    end
  end
end
