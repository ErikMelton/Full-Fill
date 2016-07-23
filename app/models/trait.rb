class Trait < ActiveRecord::Base
  has_one :facet
  # attr_accessible :traitname, :trait_desc, :facet_id
end
